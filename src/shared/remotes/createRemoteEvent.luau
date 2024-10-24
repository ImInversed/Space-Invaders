local eventsFolder = require(script.Parent.eventsFolder)
local findRemote = require(script.Parent.findRemote)

local INVALID_EVENT_NAME =
	"%s is invalid as it follows the name of another event. Check to see if you have duplicate remote names."

local function createEvent(name: string): RemoteEvent
	local repeatRemote = findRemote(name)

	if repeatRemote then
		warn(INVALID_EVENT_NAME:format(name))

		return repeatRemote
	end

	local remoteEvent = Instance.new("RemoteEvent")
	remoteEvent.Name = name
	remoteEvent.Parent = eventsFolder

	return remoteEvent
end

return createEvent
