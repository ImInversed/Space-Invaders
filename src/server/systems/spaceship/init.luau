local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local shared = ReplicatedStorage.Shared
local remotes = require(shared.remotes)

local doEnemyBehavior = require(script.doEnemyBehavior)

local assets = ReplicatedStorage.Assets
local worldEaters = assets.Enemies.WorldEaters

local spaceships = {}
local cframes = {}
local velocities = {}
local states = {}

local playerShipCreated = remotes.createEvent("playerShipCreated")

local function createPlayerSpaceship(player: Player)
	playerShipCreated:fire(player)
end

local function createEnemySpaceship(family: string, spaceshipType: string, cframe: CFrame, initialState: Vector3)
	if family == "WorldEaters" then
		local spaceshipModel = worldEaters:FindFirstChild(spaceshipType)

		if not spaceshipModel then
			warn(("spaceship model %s does not exist"):format(spaceshipType))
		end

		spaceshipModel = spaceshipModel:Clone()
		spaceshipModel.Parent = workspace

		table.insert(spaceships, spaceshipModel)
		table.insert(cframes, cframe)
		table.insert(velocities, Vector3.zero)
		table.insert(states, initialState) -- Current game time, row
	end
end

RunService.Heartbeat:Connect(function(deltaTime)
	doEnemyBehavior(cframes, spaceships, velocities, states, deltaTime)

	for index, spaceship in spaceships do
		local targetCFrame = cframes[index] + velocities[index] * deltaTime

		cframes[index] = targetCFrame

		spaceship:PivotTo(targetCFrame)
	end
end)

return {
	createEnemySpaceship = createEnemySpaceship,
	createPlayerSpaceship = createPlayerSpaceship,
}
