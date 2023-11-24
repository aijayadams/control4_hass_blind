--[[=============================================================================
    Get, Handle and Dispatch message functions

    Copyright 2015 Control4 Corporation. All Rights Reserved.
===============================================================================]]

-- This macro is utilized to identify the version string of the driver template version used.
if (TEMPLATE_VERSION ~= nil) then
	TEMPLATE_VERSION.device_messages = "2015.11.30"
end

--[[=============================================================================
    GetMessage()
  
    Description:
    Used to retrieve a message from the communication buffer. Each driver is
    responsible for parsing that communication from the buffer.
  
    Parameters:
    None
  
    Returns:
    A single message from the communication buffer
===============================================================================]]
function GetMessage()
	local message = ""
	
	if ((gReceiveBuffer ~= nil) and (gReceiveBuffer ~= "")) then

		--TODO: Implement a routine which will parse out a single message
		--      from the receive buffer(gReceiveBuffer)
		message = ""
	end

	--TODO: Once a complete message is found in the buffer remove it and 
	--      return the message
	gReceiveBuffer = ""

	return message
end

--[[=============================================================================
    HandleMessage(message)]

    Description
    This is where we parse the messages returned from the GetMessage()
    function into a command and data. The call to 'DispatchMessage' will use the
    'name' variable as a key to determine which handler routine, function, should
    be called in the DEV_MSG table. The 'value' variable will then be passed as
    a string parameter to that routine.

    Parameters
    message - Message string containing the function and value to be sent to DispatchMessage

    Returns
    Nothing
===============================================================================]]
function HandleMessage(message)
	LogTrace("HandleMessage. Message is ==>%s<==", message)

	-- TODO: Parse messages and DispatchMessage

	DispatchMessage(name, value)
end

--[[=============================================================================
    DispatchMessage(MsgKey, MsgData)

    Description
    Parse routine that will call the routines to handle the information returned
    by the connected system.

    Parameters
    MsgKey(string)  - The function to be called from within DispatchMessage
    MsgData(string) - The parameters to be passed to the function found in MsgKey

    Returns
    Nothing
===============================================================================]]
function DispatchMessage(MsgKey, MsgData)
	if (DEV_MSG[MsgKey] ~= nil and (type(DEV_MSG[MsgKey]) == "function")) then
		LogInfo("DEV_MSG.%s:  %s", MsgKey, MsgData)
		local status, err = pcall(DEV_MSG[MsgKey], MsgData)
		if (not status) then
			LogError("LUA_ERROR: %s", err)
		end
	else
		LogTrace("HandleMessage: Unhandled command = %s, data = %s", MsgKey, MsgData)
	end
end

function DEV_MSG.Moving(value)
    LogTrace("DEV_MSG.Moving(), value = " .. value)
	local level_target =  value	
	local ramp_rate = 1
	--get the current level stored in the proxy class
	local level = gBlindProxy:GetLevel()
    gBlindProxy:dev_Moving(level,level_target,ramp_rate)
end

function DEV_MSG.Stopped(value)
    LogTrace("DEV_MSG.Stopped(), value = " .. value)
	local level = value	
    gBlindProxy:dev_Stopped(level)
end