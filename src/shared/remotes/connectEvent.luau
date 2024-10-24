local RunService = game:GetService("RunService")

local getRemoteEvent = require(script.Parent.getRemoteEvent)
local RemoteClient = require(script.Parent.RemoteClient)
local RemoteServer = require(script.Parent.RemoteServer)

local runContext: "server" | "client" = if RunService:IsServer() then "server" else "client"

local function connectEvent(name: string)
	local remoteEvent = getRemoteEvent(name)

	assert(remoteEvent, ("Could not find remote event by name %s"):format(name))

	return runContext == "client" and RemoteClient.new(remoteEvent) or RemoteServer.new(name)
end

return connectEvent
