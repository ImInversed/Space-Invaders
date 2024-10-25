local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local shared = ReplicatedStorage.Shared
local remotes = require(shared.remotes)

local doEnemyBehavior = require(script.doEnemyBehavior)

local assets = ReplicatedStorage.Assets
local worldEaters = assets.Enemies.WorldEaters

local cframes = {}
local velocities = {}
local states = {}
local healths = {}

local playerShipCreated = remotes.createEvent("playerShipCreated")
local shipCreated = remotes.createEvent("shipCreated")
local shipDestroyed = remotes.createEvent("shipDestroyed")
local shipsUpdated = remotes.createEvent("shipsUpdated")
local projectileHit = remotes.connectEvent("projectileHit")

local function createPlayerSpaceship(player: Player)
	playerShipCreated:fire(player)
end

local function createEnemySpaceship(family: string, spaceshipType: string, initialCFrame: CFrame, initialState: Vector3)
	if family == "WorldEaters" then
		local spaceshipModel = worldEaters:FindFirstChild(spaceshipType)

		if not spaceshipModel then
			warn(("spaceship model %s does not exist"):format(spaceshipType))

			return
		end

		table.insert(cframes, initialCFrame)
		table.insert(velocities, Vector3.zero)
		table.insert(states, initialState)
		table.insert(healths, 100)

		shipCreated:fireAll(family, spaceshipType)
	end
end

local function getEnemies()
	return #cframes
end

RunService.Heartbeat:Connect(function(deltaTime)
	doEnemyBehavior(cframes, velocities, states, deltaTime)

	for index = 1, #cframes do
		local targetCFrame = cframes[index] + velocities[index] * deltaTime

		cframes[index] = targetCFrame
	end

	shipsUpdated:fireAll(cframes, states)
end)

projectileHit:connect(function(_: Player, index: number)
	healths[index] -= 25

	if healths[index] < 0 then
		table.remove(cframes, index)
		table.remove(velocities, index)
		table.remove(states, index)
		table.remove(healths, index)

		shipDestroyed:fireAll(index)
	end
end)

return {
	createEnemySpaceship = createEnemySpaceship,
	createPlayerSpaceship = createPlayerSpaceship,
	getEnemies = getEnemies,
}
