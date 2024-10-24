local cframes = {}
local velocities = {}
local accelerations = {}
local models = {}

local function addEntity(model: Model): number
	table.insert(cframes, model:GetPivot())
	table.insert(velocities, Vector3.zero)
	table.insert(accelerations, Vector3.zero)
	table.insert(models, model)

	return #cframes
end

local function _processEnemies()
	for index, cframe in cframes do
		local velocity = velocities[index]
		local acceleration = accelerations[index]

		velocities[index] += acceleration
		cframes[index] += velocity
	end
end

return {}
