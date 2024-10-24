local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local IS_SERVER = RunService:IsServer()
local EVENTS_FOLDER_NAME = "Events"

local eventsFolder = nil

if IS_SERVER then
	eventsFolder = Instance.new("Folder")
	eventsFolder.Name = EVENTS_FOLDER_NAME
	eventsFolder.Parent = ReplicatedStorage
else
	eventsFolder = ReplicatedStorage:WaitForChild(EVENTS_FOLDER_NAME)
end

return eventsFolder :: Folder
