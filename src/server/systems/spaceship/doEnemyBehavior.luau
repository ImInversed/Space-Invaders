local projectile = require(script.Parent.Parent.projectile)

local rows = { 100, 80, 60 }

local rng = Random.new()

local function doEnemyBehavior(cframes: { CFrame }, velocities: { Vector3 }, states: { Vector3 }, deltaTime: number)
	for i = 1, #cframes do
		local cframe = cframes[i]
		local state = states[i]

		local shot = 1

		if state.Z > 50 then
			shot = 0

			projectile.createProjectile(cframe, Vector3.new(-40, 0, 0))
		end

		states[i] = Vector3.new(
			state.X + deltaTime,
			rng:NextNumber() > 0.999 and rows[rng:NextInteger(1, #rows)] or state.Y,
			(state.Z + 1) * shot
		)
		velocities[i] = Vector3.new(state.Y - cframe.X, 0, (state.X % 8) > 4 and 10 or -10)
	end
end

return doEnemyBehavior
