--author Himanshu Sharma
local App42Log = {}
local debugFlag = false

function App42Log:isDebug()
  return debugFlag
end
function App42Log:setDebug(debugValue)
  debugFlag = debugValue
end
		
function App42Log:info(msg)
  print(msg)
end
function App42Log:debug(msg)
  if (debugFlag) then
    print(msg)
    end
end
function App42Log:error(msg)
  print(msg)
end
function App42Log:fatal(msg)
	print(msg)
end

return App42Log