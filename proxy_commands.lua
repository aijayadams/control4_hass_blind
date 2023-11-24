--[[=============================================================================
    Commands received from the blind proxy (ReceivedFromProxy)

    Copyright 2015 Control4 Corporation. All Rights Reserved.
===============================================================================]]

-- This macro is utilized to identify the version string of the driver template version used.
if (TEMPLATE_VERSION ~= nil) then
	TEMPLATE_VERSION.proxy_commands = "2015.11.30"
end

--[[=============================================================================
    STOP()

    Description
    Stop the blinds

    Parameters
    none

    Notifies
    When a driver stops the blinds it should use he STOPPED notify to tell the proxy and UI's that the blind has stopped and where at if known.
===============================================================================]]
function STOP(bindingID)
    LogTrace("STOP")

    -- TODO:
    -- build the command using the function parameters and send it to the device here        
	local url = "http://" .. HASS_HOST .. ":" .. HASS_PORT .."/api/services/cover/stop_cover"
	local headers = {
		['Authorization'] = 'Bearer ' .. TOKEN,
        ['Content-Type'] = 'application/json'
	}

    local data = '{"entity_id": "' .. ENTITY .. '"}'
	print ('Sending POST to ' .. url)
	urlPost(url, data, headers)
    -- PackAndQueueCommand("STOP", command)
end

--[[=============================================================================
    LEVEL_TOGGLE()

    Description
    Toggle the blinds

    Parameters
    none

    Notifies
    When a driver toggles the blinds it should use he ??? notify to tell the proxy and UI's that the blind has ???.
===============================================================================]]
function LEVEL_TOGGLE(bindingID)
    LogTrace("LEVEL_TOGGLE")
    
    -- TODO:
    -- build the command using the function parameters and send it to the device here
    local command = ""

    --PackAndQueueCommand("LEVEL_TOGGLE", command)
end

--[[=============================================================================
    SET_LEVEL_TARGET(level_target)

    Description
    Incoming command request for a blind level to be changed

    Parameters
    level_target - integer value of the target level the blinds should go to
    
    Notifies
    When a driver begins to move the hardware it should use the MOVING notify to tell the proxy and UI's that the blind is moving and where it's expected to stop at.
===============================================================================]]
function SET_LEVEL_TARGET(bindingID, level_target)
    LogTrace("SET_LEVEL_TARGET, level_target = " .. level_target)
	
    -- TODO:
    -- build the command using the function parameters and send it to the device here
    
	local url = "http://" .. HASS_HOST .. ":" .. HASS_PORT .."/api/services/cover/set_cover_position"
	local headers = {
		['Authorization'] = 'Bearer ' .. TOKEN,
        ['Content-Type'] = 'application/json'
	}

    local data = '{"entity_id": "' .. ENTITY .. '", "position": "' .. level_target .. '"}'
	print ('Sending POST to ' .. url)
	urlPost(url, data, headers)

    DEV_MSG.Moving(level_target)

    local command = ""

    --PackAndQueueCommand("SET_LEVEL_TARGET", command)
end

function GET_GROUP_BLINDS()

    print("GET_GROUP_BLINDS, all the way in AIJAY CODE")
    return 5001

end
--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
-- Initialization function called from 
-- OnNetworkStatusChanged() / OnSerialConnectionChanged()
--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
function initialize()

    -- TODO:
    -- send message to device to get current level...
    FetchPosition()
    
end
