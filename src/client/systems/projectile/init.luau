local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local shared = ReplicatedStorage.Shared
local remotes = require(shared.remotes)

local projectileTemplate = Instance.new("Part")
projectileTemplate.Anchored = true
projectileTemplate.CanCollide = false
projectileTemplate.Size = Vector3.new(3, 0.5, 0.5)
projectileTemplate.Color = Color3.new(0, 1, 0)
projectileTemplate.Material = "Neon"
projectileTemplate.Parent = workspace

local createProjectileRemote = remotes.connectEvent("createProjectile")
local projectileHit = remotes.connectEvent("projectileHit")

local models = {}
local cframes = {}
local velocities = {}
local tags = {}

local function createProjectile(origin: CFrame, velocity: Vector3, tag: string)
	local projectileModel = projectileTemplate:Clone()
	projectileModel.Parent = workspace

	table.insert(models, projectileModel)
	table.insert(cframes, origin)
	table.insert(velocities, velocity)
	table.insert(tags, tag)
end

RunService.Heartbeat:Connect(function(deltaTime)
	for i = 1, #velocities do
		local cframe = cframes[i]

		cframes[i] = cframe + velocities[i] * deltaTime

		local collision = false

		for j = 1, #velocities do
			if i == j then
				continue
			end

			local otherCFrame = cframes[j]
			local distance = (otherCFrame.Position - cframe.Position).Magnitude

			if distance < 5 and tags[j] == "red" then
				models[i]:Destroy()

				table.remove(models, i)
				table.remove(cframes, i)
				table.remove(velocities, i)
				table.remove(tags, i)

				collision = true

				break
			end
		end

		if collision then
			break
		end
	end

	workspace:BulkMoveTo(models, cframes, Enum.BulkMoveMode.FireCFrameChanged)
end)

createProjectileRemote:connect(function(origin: CFrame, velocity: Vector3)
	createProjectile(origin, velocity, "green")
end)

return {
	createProjectile = createProjectile,
}
