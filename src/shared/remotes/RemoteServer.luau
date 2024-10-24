local Players = game:GetService("Players")
local createRemoteEvent = require(script.Parent.createRemoteEvent)

local RemoteServer = {}
RemoteServer.__index = RemoteServer

function RemoteServer.new(name: string)
	local self = setmetatable({}, RemoteServer)

	self._event = createRemoteEvent(name)

	return self
end

function RemoteServer:connect(callback: (player: Player, any: any) -> nil): RBXScriptConnection
	return self._event.OnServerEvent:Connect(callback)
end

function RemoteServer:connectMatter(): (RemoteEvent, string)
	return self._event, "OnServerEvent"
end

function RemoteServer:once(callback: (player: Player, any: any) -> nil)
	self._event.OnServerEvent:Once(callback)
end

function RemoteServer:fire(player: Player, ...: any?)
	self._event:FireClient(player, ...)
end

function RemoteServer:fireFor(players: { Player }, ...: any?)
	for _, player in players do
		self._event:FireClient(player, ...)
	end
end

function RemoteServer:fireAll(...: any?)
	self._event:FireAllClients(...)
end

function RemoteServer:fireFilter(predicate: (player: Player) -> boolean, ...: any?)
	for _, player in Players:GetPlayers() do
		if predicate(player) then
			self._event:FireClient(player, ...)
		end
	end
end

return RemoteServer
