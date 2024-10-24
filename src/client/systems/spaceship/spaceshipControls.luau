local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local projectile = require(script.Parent.Parent.projectile)

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

	local lastShot = 0
	local gunIndex = 1
	local guns = spaceship:FindFirstChild("Guns") :: Folder
	local children = guns:GetChildren()

	RunService.Heartbeat:Connect(function(deltaTime: number)
		local cframe = spaceship:GetPivot()

		spaceship:PivotTo(
			CFrame.new(cframe.X, cframe.Y, math.clamp(cframe.Z + direction * 20 * deltaTime, -45, 45))
				* CFrame.Angles(0, -math.pi / 2, 0)
		)

		lastShot += deltaTime

		if lastShot > 0.5 and UserInputService:IsKeyDown(Enum.KeyCode.Space) then
			local nextGun = children[gunIndex]

			projectile.createProjectile(CFrame.new(nextGun.Position), Vector3.new(40, 0, 0), "red")

			lastShot = 0
			gunIndex += 1

			if gunIndex > #children then
				gunIndex = 1
			end
		end
	end)
end

return spaceshipControls
