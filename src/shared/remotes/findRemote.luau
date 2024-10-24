local eventsFolder = require(script.Parent.eventsFolder)

local function findRemote(name: string): RemoteEvent?
	for _, child in eventsFolder:GetDescendants() do
		if child:IsA("Folder") then
			continue
		end

		if child.Name == name then
			return child
		end
	end

	return nil
end

return findRemote
