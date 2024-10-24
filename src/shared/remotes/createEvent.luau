local RunService = game:GetService("RunService")

local RemoteServer = require(script.Parent.RemoteServer)

local IS_SERVER = RunService:IsServer()

local function createEvent(name: string)
	assert(IS_SERVER, "Cannot run createEvent on client!")

	return RemoteServer.new(name)
end

return createEvent
