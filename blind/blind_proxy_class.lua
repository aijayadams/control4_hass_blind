--[[=============================================================================
    Blind Proxy Class

    Copyright 2015 Control4 Corporation. All Rights Reserved.
===============================================================================]]

-- This macro is utilized to identify the version string of the driver template version used.
if (TEMPLATE_VERSION ~= nil) then
	TEMPLATE_VERSION.blind_proxy_class = "2015.03.02"
end

BlindProxy = inheritsFrom(nil)

function BlindProxy:construct(bindingID)
	-- member variables
	self._BindingID = bindingID
	
	self:Initialize()
end

function BlindProxy:Initialize()
	self._Level = 1
	self._LevelTarget = 1
	self._LevelOpen = 2
	self._LevelClosed = 0
	self._LevelClosedSecondary = nil
	self._LevelDiscreteControl = false
	self._LevelResolution = 1
	self._LevelUnknown = -9999
end

--[[=============================================================================
    Blind Proxy Commands(PRX_CMD)
===============================================================================]]

function BlindProxy:prx_STOP(bindingID)
	LogTrace("BlindProxy:prx_STOP")
	STOP(bindingID)
end

function BlindProxy:prx_LEVEL_TOGGLE(bindingID)
	LogTrace("BlindProxy:prx_LEVEL_TOGGLE")
	LEVEL_TOGGLE(bindingID)
end


function BlindProxy:prx_GET_GROUP_BLINDS(bindingID)
	LogTrace("BlindProxy:prx_GET_GROUP_BLINDS")
	GET_GROUP_BLINDS(bindingID)
end


function BlindProxy:prx_SET_LEVEL_TARGET(bindingID, tParams)
	LogTrace("BlindProxy:prx_SET_LEVEL_TARGET")
	local level_target = tonumber(tParams["LEVEL_TARGET"])

	if (level_target ~= nil) then
		SET_LEVEL_TARGET(bindingID, level_target)
	else
		LogTrace("prx_SET_LEVEL Missing or invalid parameter for: level_target")
	end
end

--[[=============================================================================
    Blind Proxy Methods
===============================================================================]]

function BlindProxy:GetCanStop()
	return self._CanStop
end

function BlindProxy:GetLevel()
	return self._Level
end

function BlindProxy:GetLevelTarget()
	return self._LevelTarget
end

function BlindProxy:GetLevelOpen()
	return self._LevelOpen
end

function BlindProxy:GetLevelClosed()
	return self._LevelClosed
end

function BlindProxy:GetLevelClosedSecondary()
	return self._LevelClosedSecondary
end

function BlindProxy:GetLevelDiscreteControl()
	return self._LevelDiscreteControl
end

function BlindProxy:GetLevelResolution()
	return self._LevelResolution
end

function BlindProxy:GetLevelUnknown()
	return self._LevelUnknown
end

function BlindProxy:GetLevelVarious()
	return 9999
end


--[[=============================================================================
    Blind Proxy Notifies
===============================================================================]]

function BlindProxy:dev_Moving(level,level_target,ramp_rate)
	-- level_target: the target level that the blinds will eventually stop at.
	-- ramp_rate: the number of milliseconds it will take the blinds will be moving before they stop.
	if (type(level_target) == "number" and type(ramp_rate) == "number") then
		LogTrace("dev_Moving Sending Notify, level_target = " .. level_target .. ", ramp_rate: " .. ramp_rate)
		self._LevelTarget = level_target
		NOTIFY.MOVING(self._BindingID, level, level_target, ramp_rate)
	else
		LogWarn("dev_Moving Invalid notify parameter value for Moving")
	end
end

function BlindProxy:dev_Stopped(level)
	-- level_target: the level that the blinds stopped at.
	if (type(level) == "number") then
		self._Level = level
		self._LevelTarget = level
		NOTIFY.STOPPED(self._BindingID, level)
	else
		LogWarn("Invalid notify parameter value for Stopped:" .. (level ~= nil and level or "nil"))
	end
end

function BlindProxy:dev_SetCanStop(can_stop)
	-- can_stop: boolean value if the blind can be stopped while it's moving
	if (type(can_stop) == "boolean") then
		self._CanStop = can_stop
		NOTIFY.SET_CAN_STOP(self._BindingID, can_stop)
	else
		LogWarn("Invalid notify parameter value for SetCanStop: " .. tostring(can_stop))
	end
end

function BlindProxy:dev_EnableLevel(level_discrete_control,level_closed,level_open,level_closed_secondary,level_resolution,level_unknown)
	-- has_level: boolean value if the blinds supports more than up/down/stop
	--
	self._HasLevel = true
	if (type(level_discrete_control) == "boolean" and self._LevelDiscreteControl ~= level_discrete_control) then
		self._LevelDiscreteControl = level_discrete_control
	end
	if(level_closed ~= nil and type(level_closed) == "number") then
		self._LevelClosed = level_closed
	end
	if(level_open ~= nil and type(level_open) == "number") then
		self._LevelOpen = level_open
	end
	self._LevelClosedSecondary = level_closed_secondary
	if(level_resolution ~= nil and type(level_resolution) == "number") then
		self._LevelResolution = level_resolution
	end
	if(level_unknown ~= nil and type(level_unknown) == "number") then
		self._LevelUnknown = level_unknown
	end

	NOTIFY.SET_HAS_LEVEL(self._BindingID, true, self._LevelDiscreteControl, self._LevelClosed, self._LevelOpen, self._LevelClosedSecondary, self._LevelResolution, self._LevelUnknown)
end

function BlindProxy:dev_DisableLevel()
	-- has_level: boolean value if the blinds supports more than up/down/stop
	--
	if (type(level_open) == "boolean" and self._HasLevel ~= false) then
		self._HasLevel = false
		NOTIFY.SET_HAS_LEVEL(self._BindingID, false, false, nil, nil, nil, nil, nil)
	end
end

function BlindProxy:dev_SetBlindType(blind_type)
	-- blind_type: integer value for the corresponding type.  See enum list in blind_proxy_constants.lua.
	--
	if (type(blind_type) == "boolean" and self._BlindType ~= blind_type) then
		self._BlindMovement = blind_type
		NOTIFY.SET_BLIND_TYPE(self._BindingID, blind_type)
	end
end

function BlindProxy:dev_SetBlindMovement(blind_movement)
	-- blind_movement: interger value for the corresponding movement.  See enum list in blind_proxy_constants.lua.
	--
	if (type(blind_movement) == "boolean" and self._BlindMovement ~= blind_movement) then
		self._BlindMovement = blind_movement
		NOTIFY.SET_BLIND_MOVEMENT(self._BindingID, blind_movement)
	end
end
