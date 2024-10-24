local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local function spaceshipControls(spaceship: Model)
	local direction = 0

	local function goDirection(input: number)
		direction += input
	end

	UserInputService.InputBegan:Connect(function(input: InputObject)
		if input.KeyCode == Enum.KeyCode.A then
			goDirection(-1)
		elseif input.KeyCode == Enum.KeyCode.D then
			goDirection(1)
		end
	end)

	UserInputService.InputEnded:Connect(function(input: InputObject)
		if input.KeyCode == Enum.KeyCode.A then
			goDirection(1)
		elseif input.KeyCode == Enum.KeyCode.D then
			goDirection(-1)
		end
	end)

	RunService.Heartbeat:Connect(function(deltaTime: number)
		local cframe = spaceship:GetPivot()

		spaceship:PivotTo(cframe + Vector3.new(0, 0, direction * 20 * deltaTime))
	end)
end

return spaceshipControls
