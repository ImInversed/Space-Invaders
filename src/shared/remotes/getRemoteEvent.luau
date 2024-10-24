local eventsFolder = require(script.Parent.eventsFolder)

-- use to use promises, but this game doesn't use libraries.
local function _waitForInstance(parent: Instance, instanceName: string)
	return parent:WaitForChild(instanceName)
end

local function getEvent(name: string)
	return _waitForInstance(eventsFolder, name)
end

return getEvent
