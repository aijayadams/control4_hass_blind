--[[=============================================================================
    Command Functions Received From Proxy to the Blind Driver

    Copyright 2015 Control4 Corporation. All Rights Reserved.
===============================================================================]]

-- This macro is utilized to identify the version string of the driver template version used.
if (TEMPLATE_VERSION ~= nil) then
	TEMPLATE_VERSION.blind_proxy_commands = "2015.11.30"
end

function PRX_CMD.STOP(bindingID, tParams)
	gBlindProxy:prx_STOP(bindingID, tParams)
end

function PRX_CMD.LEVEL_TOGGLE(bindingID, tParams)
	gBlindProxy:prx_LEVEL_TOGGLE(bindingID, tParams)
end

function PRX_CMD.SET_LEVEL_TARGET(bindingID, tParams)
	gBlindProxy:prx_SET_LEVEL_TARGET(bindingID, tParams)
end

function PRX_CMD.GET_GROUP_BLINDS(bindingID, tParams)
	gBlindProxy:prx_GET_GROUP_BLINDS(bingingID, tParams)
end
