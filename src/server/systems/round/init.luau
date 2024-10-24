local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local spaceship = require(script.Parent.spaceship)

local round = {}
round.roundTime = 0
round.hasStarted = false

RunService.Heartbeat:Connect(function(deltaTime)
	if round.hasStarted then
		round.roundTime += deltaTime
	end
end)

local function setupRound(player: Player)
	round.hasStarted = true
	round.roundTime = 0

	spaceship.createPlayerSpaceship(player)
	spaceship.createEnemySpaceship("WorldEaters", "Heavy", CFrame.new(60, 20, -45), Vector3.new(4, 80, 0))
	spaceship.createEnemySpaceship("WorldEaters", "Heavy", CFrame.new(60, 20, 45), Vector3.new(0, 80, 0))
end

Players.PlayerAdded:Connect(setupRound)

for _, player in Players:GetPlayers() do
	setupRound(player)
end

return round
