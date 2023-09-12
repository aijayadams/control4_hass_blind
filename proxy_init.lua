--[[=============================================================================
    Initialization Functions

    Copyright 2015 Control4 Corporation. All Rights Reserved.
===============================================================================]]

-- This macro is utilized to identify the version string of the driver template version used.
if (TEMPLATE_VERSION ~= nil) then
	TEMPLATE_VERSION.proxy_init = "2015.11.30"
end

function ON_DRIVER_EARLY_INIT.proxy_init()
	-- declare and initialize global variables

end

function ON_DRIVER_INIT.proxy_init()
	-- instantiate the blind proxy class
	gBlindProxy = BlindProxy:new(DEFAULT_PROXY_BINDINGID)
end

function ON_DRIVER_LATEINIT.proxy_init()
	
end
