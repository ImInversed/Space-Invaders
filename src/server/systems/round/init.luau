local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local spaceship = require(script.Parent.spaceship)

local row = 45

local round = {}
round.roundTime = 0
round.hasStarted = false
round.enemiesRemaining = 10

RunService.Heartbeat:Connect(function(deltaTime)
	if not round.hasStarted then
		return
	end

	local enemies = spaceship.getEnemies()

	if enemies < 2 and round.enemiesRemaining > 0 then
		row *= -1

		spaceship.createEnemySpaceship(
			"WorldEaters",
			"LightShip",
			CFrame.new(60, 20, row),
			Vector3.new(row < 0 and 4 or 0, 80, 0)
		)

		round.enemiesRemaining -= 1
	end

	round.roundTime += deltaTime
end)

local function setupRound(player: Player)
	round.hasStarted = true
	round.roundTime = 0

	spaceship.createPlayerSpaceship(player)
end

Players.PlayerAdded:Connect(setupRound)

for _, player in Players:GetPlayers() do
	setupRound(player)
end

return round
