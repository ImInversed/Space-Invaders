local ReplicatedStorage = game:GetService("ReplicatedStorage")

local client = ReplicatedStorage.Client
local systems = client.systems

for _, system in systems:GetChildren() do
	require(system)
end
