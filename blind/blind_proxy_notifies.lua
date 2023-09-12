--[[=============================================================================
    Notification Functions

    Copyright 2015 Control4 Corporation. All Rights Reserved.
===============================================================================]]

-- This macro is utilized to identify the version string of the driver template version used.
if (TEMPLATE_VERSION ~= nil) then
	TEMPLATE_VERSION.blind_proxy_notifies = "2015.11.30"
end

function NOTIFY.MOVING(bindingID, level, level_target, ramp_rate)
	LogTrace("NOTIFY.MOVING(bindingID = " .. bindingID .. ", level = " .. (level ~= nil and level or "last sent") .. ", level_target = " .. level_target .. ", ramp_rate = " .. ramp_rate)

	local tParams = {}
	if level ~= nil then
		tParams["LEVEL"] = level
	end
	tParams["LEVEL_TARGET"] = level_target
	tParams["RAMP_RATE"] = ramp_rate

	SendNotify("MOVING", tParams, bindingID)
end

function NOTIFY.STOPPED(bindingID, level)
	LogTrace("NOTIFY.STOPPED(bindingID = %s, level = %s", bindingID, level)

	local tParams = {}
	tParams["LEVEL"] = level

	SendNotify("STOPPED", tParams, bindingID)
end

function NOTIFY.SET_CAN_STOP(bindingID, can_stop)
	LogTrace("NOTIFY.SET_CAN_STOP(bindingID = %s, can_stop = %s", bindingID, tostring(can_stop))

	local tParams = {}
	tParams["CAN_STOP"] = can_stop

	SendNotify("SET_CAN_STOP", tParams, bindingID)
end

function NOTIFY.SET_HAS_LEVEL(bindingID, has_level, level_discrete_control, level_closed, level_open, level_closed_secondary, level_resolution, level_unknown)
	LogTrace("NOTIFY.SET_HAS_LEVEL(bindingID = %s, has_level = %s, level_discrete_control = %s, level_closed = %s, level_open = %s, level_closed_secondary = %s, level_resolution = %s, level_unknown = %s", bindingID, (has_level and "Yes" or "No"), (level_discrete_control and "Yes" or "No"), level_closed, level_open, (level_closed_secondary ~= nil and level_closed_secondary or "Disabled"), level_resolution, level_unknown)

	local tParams = {}
	tParams["HAS_LEVEL"] = has_level
	if level_closed ~= nil then
		tParams["LEVEL_CLOSED"] = level_closed
	end
	if level_open ~= nil then
		tParams["LEVEL_OPEN"] = level_open
	end
	if level_closed_secondary == nil then
		tParams["HAS_LEVEL_CLOSED_SECONDARY"] = false
	else
		tParams["HAS_LEVEL_CLOSED_SECONDARY"] = true
		tParams["LEVEL_CLOSED_SECONDARY"] = level_closed_secondary
	end
	if level_resolution ~= nil then
		tParams["LEVEL_RESOLUTION"] = level_resolution
	end
	if level_unknown ~= nil then
		tParams["LEVEL_UNKNOWN"] = level_unknown
	end
		
	if level_discrete_control ~= nil then
		tParams["LEVEL_DISCRETE_CONTROL"] = level_discrete_control
	end

	SendNotify("SET_HAS_LEVEL", tParams, bindingID)
end

function NOTIFY.SET_TYPE(bindingID, blind_type)
	LogTrace("NOTIFY.SET_TYPE(bindingID = %s, type = %s", bindingID, blind_type)

	local tParams = {}
	tParams["TYPE"] = blind_type

	SendNotify("SET_TYPE", tParams, bindingID)
end

function NOTIFY.SET_MOVEMENT(bindingID, movement)
	LogTrace("NOTIFY.SET_MOVEMENT(bindingID = %s, movement = %s", bindingID, movement)

	local tParams = {}
	tParams["MOVEMENT"] = movement

	SendNotify("SET_MOVEMENT", tParams, bindingID)
end
