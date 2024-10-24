local rows = { 100, 80, 60 }

local rng = Random.new()

local function doEnemyBehavior(
	cframes: { CFrame },
	models: { Model },
	velocities: { Vector3 },
	states: { Vector3 },
	deltaTime: number
)
	for i = 1, #models do
		local spaceshipModel = models[i]
		local cframe = cframes[i]
		local velocity = velocities[i]
		local state = states[i]

		states[i] =
			Vector3.new(state.X + deltaTime, rng:NextNumber() > 0.999 and rows[rng:NextInteger(1, #rows)] or state.Y, 0)
		velocities[i] = Vector3.new(state.Y - cframe.X, 0, (state.X % 8) > 4 and 10 or -10)
	end
end

return doEnemyBehavior
