local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local shared = ReplicatedStorage.Shared
local remotes = require(shared.remotes)

local assets = ReplicatedStorage.Assets
local playerShip = assets.PlayerShip

local spaceshipControls = require(script.spaceshipControls)

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

local playerShipCreated = remotes.connectEvent("playerShipCreated")

playerShipCreated:connect(function()
	local spaceship = playerShip:Clone()
	spaceship:PivotTo(CFrame.new(0, 20, 0) * CFrame.Angles(0, -math.pi / 2, 0))
	spaceship.Parent = workspace

	local seat = spaceship.VehicleSeat
	local model = Players:CreateHumanoidModelFromUserId(player.UserId)
	model:PivotTo(seat.CFrame + Vector3.new(0, 5, 0))
	model.Parent = spaceship

	local weld = Instance.new("WeldConstraint")
	weld.Part0 = seat
	weld.Part1 = model.PrimaryPart
	weld.Parent = seat

	model.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None

	spaceshipControls(spaceship)

	RunService.RenderStepped:Connect(function()
		local position = spaceship:GetPivot().Position

		camera.CFrame = CFrame.lookAt(position + Vector3.new(-20, 80, 0), position + Vector3.new(20, 0, 0))
	end)
end)

return nil
