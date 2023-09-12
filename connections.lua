--[[=============================================================================
    Functions for managing the status of the drivers bindings and connection state
 
    Copyright 2015 Control4 Corporation. All Rights Reserved.
===============================================================================]]
require "common.c4_network_connection"
require "common.c4_url_connection"

-- This macro is utilized to identify the version string of the driver template version used.
if (TEMPLATE_VERSION ~= nil) then
	TEMPLATE_VERSION.connections = "2015.11.30"
end

-- constants
COM_USE_ACK = false
COM_COMMAND_DELAY_MILLISECONDS = 250
COM_COMMAND_RESPONSE_TIMEOUT_SECONDS = 4

NETWORK_PORT = 8123
NETWORK_BINDING_ID = 1337



--[[=============================================================================
    OnNetworkConnectionChanged(idBinding, bIsBound)
  
    Description:
    Function called when a network binding changes state(bound or unbound).
  
    Parameters:
    idBinding(int) - ID of the binding whose state has changed.
    bIsBound(bool) - Whether the binding has been bound or unbound.
  
    Returns:
    None
===============================================================================]]
function OnNetworkConnectionChanged(idBinding, bIsBound, otherDeviceId, otherBindingId)
    if (otherBindingId == nil) then
        otherBindingId = ""
    end

	LogDebug("idBinding: " .. idBinding .. ", iBound: " .. bIsBound .. ", otherDeviceId: " .. otherDeviceId .. ", otherBindingId: " .. otherBindingId)

    print("connections.lua OnConnectionChanged")
    print("idBinding: " .. idBinding .. ", iBound: " .. bIsBound .. ", otherDeviceId: " .. otherDeviceId .. ", otherBindingId: " .. otherBindingId)
end

--[[=============================================================================
    OnNetworkStatusChanged(idBinding, nPort, sStatus)
  
    Description:
    Called when the network connection status changes. Sets the updated status of the specified binding
  
    Parameters:
    idBinding(int)  - ID of the binding whose status has changed
    nPort(int)      - The communication port of the specified bindings connection
    sStatus(string) - "ONLINE" if the connection status is to be set to Online,
		      any other value will set the status to Offline
  
    Returns:
    None
===============================================================================]]
function OnNetworkStatusChanged(idBinding, nPort, sStatus)
    print("connections.lua OnNetworkStatusChanged")
    print("idBinding: " .. idBinding .. ", nPort: " .. nPort .. ", sStatus: " .. sStatus)

end

--[[=============================================================================
    OnURLConnectionChanged(url)
  
    Description:
    Function called when the c4_url_connection is created.
  
    Parameters:
    url - url used by the url connection.
  
    Returns:
    None
===============================================================================]]
function OnURLConnectionChanged(url)
	
end

--[[=============================================================================
    DoEvents()
  
    Description:
    
  
    Parameters:
    None
  
    Returns:
    None
===============================================================================]]
function DoEvents()
end

--[[=============================================================================
    SendKeepAlivePollingCommand()
  
    Description:
    Sends a driver specific polling command to the connected system
  
    Parameters:
    None
  
    Returns:
    None
===============================================================================]]
function SendKeepAlivePollingCommand()
	--TODO: Implement the keep alive command for the network connected system if required.
   -- FetchPosition()
end

function OnBindingChanged(idBinding, class, bIsBound, otherDeviceId, otherBindingId)

end
