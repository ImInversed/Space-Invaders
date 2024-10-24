local ReplicatedStorage = game:GetService("ReplicatedStorage")

local shared = ReplicatedStorage.Shared
local remotes = require(shared.remotes)

local createProjectileRemote = remotes.createEvent("createProjectile")
local projectileHit = remotes.createEvent("projectileHit")

local function createProjectile(origin: CFrame, velocity: Vector3)
	createProjectileRemote:fireAll(origin, velocity)
end

projectileHit:connect(function() end)

return {
	createProjectile = createProjectile,
}
