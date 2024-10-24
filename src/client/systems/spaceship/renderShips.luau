local ReplicatedStorage = game:GetService("ReplicatedStorage")

local shared = ReplicatedStorage.Shared
local remotes = require(shared.remotes)

local assets = ReplicatedStorage.Assets
local worldEaters = assets.Enemies.WorldEaters

local shipCreated = remotes.connectEvent("shipCreated")
local shipsUpdated = remotes.connectEvent("shipsUpdated")

local spaceshipModels = {}
local cframes: { CFrame } = {}

local function onShipCreated(family: string, spaceshipType: string)
	if family == "WorldEaters" then
		local spaceshipModel: Model = worldEaters:FindFirstChild(spaceshipType)

		if not spaceshipModel then
			warn(("spaceship model %s does not exist"):format(spaceshipType))

			return
		end

		spaceshipModel = spaceshipModel:Clone()
		spaceshipModel.Parent = workspace

		table.insert(spaceshipModels, spaceshipModel)
	end
end

local function onShipsUpdated(newCFrames: { CFrame }, _: { Vector3 })
	cframes = newCFrames
end

local function renderShips()
	for i = 1, #cframes do
		local spaceshipModel = spaceshipModels[i]
		local cframe = spaceshipModel:GetPivot():Lerp(cframes[i], 0.99)

		spaceshipModel:PivotTo(cframe)
	end
end

shipCreated:connect(onShipCreated)
shipsUpdated:connect(onShipsUpdated)

return renderShips
