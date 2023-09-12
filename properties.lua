--[[=============================================================================
    Properties Code

    Copyright 2015 Control4 Corporation. All Rights Reserved.
===============================================================================]]

-- This macro is utilized to identify the version string of the driver template version used.
if (TEMPLATE_VERSION ~= nil) then
	TEMPLATE_VERSION.properties = "2015.11.30"
end

function ON_PROPERTY_CHANGED.SampleProperty(propertyValue)
    print("PropFile Property " .. strProperty)
    print("PropFile Property " .. value)
end
