local RemoteClient = {}
RemoteClient.__index = RemoteClient

function RemoteClient.new(event: RemoteEvent)
	local self = setmetatable({}, RemoteClient)

	self._event = event

	return self
end

function RemoteClient:fire(...: any)
	self._event:FireServer(...)
end

function RemoteClient:connect(callback: (any) -> nil)
	local connection = self._event.OnClientEvent:Connect(callback)

	return connection
end

function RemoteClient:connectMatter()
	return self._event, "OnClientEvent"
end

return RemoteClient
