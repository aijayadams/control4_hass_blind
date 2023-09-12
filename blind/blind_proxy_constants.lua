--[[
Copyright 2016 Control4 Corporation.  All rights reserved.

+++ blind_constants.lua +++
Constants defined or used by the blind proxy
]]


--[[
SET_MOVEMENT

Used by the protocol to inform the proxy that the driver is a particular blind movement function.  
If this is used, the proxy will disable the pulldown from being selectable by a dealer.

movement = integer:
0 	- Open/Close (Open/Close)
1 	- Up to Down (Up is open, Down is closed)
2 	- Down to Up (Down is open, Up is Closed)
3 	- Out to In (Out is Open, In is Closed)
4 	- Left to Right (Left is Open, Right is Closed)
5 	- Right to Left (Right is Open, Left is Closed)
--]]
BLIND_MOVEMENT  = {
	
	OPEN_CLOSE = 0,
	UP_TO_DOWN = 1,
	DOWN_TO_UP = 2,
	OUT_TO_IN = 3,
	LEFT_TO_RIGHT = 4,
	RIGHT_TO_LEFT = 5,
     [0] = "OPEN_CLOSE",
	"UP_TO_DOWN",
     "DOWN_TO_UP",
	"OUT_TO_IN",
	"LEFT_TO_RIGHT",
	"RIGHT_TO_LEFT",
}


--[[
SET_TYPE

Used by the protocol to inform the proxy that the driver is a particular blind type.  
If this is used, the proxy will disable the pulldown from being selectable by a dealer.

type = integer:
0 	- Shade (Default as all coverings are considered to be Shades in the industry)
1 	- Group
2 	- Blind (Since a blind has slates/louvers that often move, a blind can be bound to a louver movement for association)
3 	- Louver
4 	- Curtain
5 	- Shutter
6 	- Blackout
7 	- Opaque Glass
8 	- Awning
9 	- Door
10 	- Screen
--]]
BLIND_TYPE  = {
	
	SHADE = 0,
	GROUP = 1,
	BLIND = 2,
	LOUVER= 3,
	CURTAIN = 4,
	SHUTTER = 5,
	BLACKOUT = 6,
	OPAQUE_GLASS = 7, 
	AWNING = 8, 
	DOOR = 9, 
	SCREEN = 10,
	[0] = "SHADE",
	"GROUP",
	"BLIND",
	"LOUVER",
	"CURTAIN",
	"SHUTTER",
	"BLACKOUT",
	"OPAQUE_GLASS", 
	"AWNING", 
	"DOOR", 
	"SCREEN",
}