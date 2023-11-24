--[[=============================================================================
    Main script file for driver

    Copyright 2015 Control4 Corporation. All Rights Reserved.
===============================================================================]]
require ('drivers-common-public.global.url')
require ('drivers-common-public.global.timer')
require ('drivers-common-public.global.lib')

JSON = require ('drivers-common-public.module.json')

require "common.c4_driver_declarations"
require "common.c4_common"
require "common.c4_init"
require "common.c4_property"
require "common.c4_command"
require "common.c4_notify"
require "common.c4_utils"
require "lib.c4_timer"
require "actions"
require "device_specific_commands"
require "device_messages"
require "proxy_init"
require "proxy_commands"
require "connections"
require "helper"
require "blind.blind_proxy_class"
require "blind.blind_proxy_commands"
require "blind.blind_proxy_notifies"
require "blind.blind_proxy_constants"



-- This macro is utilized to identify the version string of the driver template version used.
if (TEMPLATE_VERSION ~= nil) then
	TEMPLATE_VERSION.driver = "2015.11.30"
end

--[[=============================================================================
    Constants
===============================================================================]]
DOORSTATION_PROXY_BINDINGID = 5001

--[[=============================================================================
    Initialization Code
===============================================================================]]
LEVEL_UNKNOWN = -9999
LEVEL_VARIOUS = 9999

POLLTIMER=nil

function ON_DRIVER_EARLY_INIT.main()
	gVariousMode = nil -- set to unset to indicate we need to calcualte if we're in variousMode
	gCanStop = nil
end

function ON_DRIVER_INIT.main()

end

function ON_DRIVER_LATEINIT.main()
	gBlindProxy:dev_Stopped(LEVEL_UNKNOWN)  -- Needed to initalize the proxy that we're in an unknonw state
	DRIVER_NAME = C4:GetDriverConfigInfo("name")
	print("my driver name is " .. DRIVER_NAME)
	SetLogName(DRIVER_NAME)
	
    for property, _ in pairs (Properties) do
		OnPropertyChanged (property)
    end

    -- Update Position based on the lastest information in HomeAssistant
    SetTimer(1337, 30000, FetchPosition, true)
end


function FetchPosition()
	local url = "http://" .. HASS_HOST .. ":" .. HASS_PORT .. "/api/states/" .. ENTITY
	local headers = {
		['Authorization'] = 'Bearer ' .. TOKEN,
        ['Content-Type'] = 'application/json'
	}
	print ('Sending GET to ' .. url)
	urlGet (url, headers, ParsePosition, contextInfo, DEFAULT_URL_OPTIONS)
end

function ParsePosition (strError, responseCode, tHeaders, data, context, url)
    print("Current Position: " .. data["attributes"]["current_position"])
    DEV_MSG.Stopped(data["attributes"]["current_position"])
end

function OpenConnection()
    --C4:CreateNetworkConnection(1337, HASS_HOST)
    FetchPosition()
end


function OnPropertyChanged (strProperty)
    local value = Properties [strProperty]
    if (value == nil) then
	   value = ''
    end
    
    if (strProperty == "HomeAssistant Host") then
        HASS_HOST = value
    elseif (strProperty == "HomeAssistant Port") then
        HASS_PORT = value
    elseif (strProperty == "Cover Entity") then
        ENTITY = value
    elseif (strProperty == "Bearer Token") then
        TOKEN = value
    end
    
    print("HASS_HOST:" .. HASS_HOST)
    print("HASS_PORT:" .. HASS_PORT)
    
    if (HASS_HOST ~= nil) then
	   print("OPENING CONNECTION")
        OpenConnection()
	   
    end

end

--[[=============================================================================
    Driver Code
===============================================================================]]
function PackAndQueueCommand(...)
    local command_name = select(1, ...) or ""
    local command = select(2, ...) or ""
    local command_delay = select(3, ...) or tonumber(Properties["Command Delay Milliseconds"])
    local delay_units = select(4, ...) or "MILLISECONDS"
    LogTrace("PackAndQueueCommand(), command_name = " .. command_name .. ", command delay set to " .. command_delay .. " " .. delay_units)
    if (command == "") then
	   LogWarn("PackAndQueueCommand(), command_name = " .. command_name .. ", command string is empty - exiting PackAndQueueCommand()")
	   return
    end
	
	-- TODO: pack command with any any required starting or ending characters
    local cmd, stx, etx
    print("PackandQueueCommand Method: " .. gControlMethod)
    if (gControlMethod == "Network") then
		-- TODO: define any required starting or ending characters. 
		stx = ""
		etx = "\r"
		cmd = stx .. command .. etx
    elseif (gControlMethod == "Serial") then
		-- TODO: define any required starting or ending characters. 
		stx = ""
		etx = "\r"
		cmd = stx .. command .. etx
    elseif (gControlMethod == "IR") then
		cmd = command
    else
		LogWarn("PackAndQueueCommand(): gControlMethod is not valid, ".. gControlMethod)
		return
    end
    gCon:QueueCommand(cmd, command_delay, delay_units, command_name)	
	
end
