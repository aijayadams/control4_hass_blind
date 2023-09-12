--[[=============================================================================
    Copyright 2015 Control4 Corporation. All Rights Reserved.
===============================================================================]]

-- This macro is utilized to identify the version string of the driver template version used.
if (TEMPLATE_VERSION ~= nil) then
	TEMPLATE_VERSION.device_specific_commands = "2015.11.30"
end

--[[=============================================================================
    ExecuteCommand Code

    Define any functions for device specific commands (EX_CMD.<command>)
    received from ExecuteCommand that need to be handled by the driver.
===============================================================================]]
function EX_CMD.GET_COMMAND_SETUP(tParams)
	LogTrace("EX_CMD.GET_COMMAND_SETUP")
	LogTrace(tParams)
	return "INFO"
end

