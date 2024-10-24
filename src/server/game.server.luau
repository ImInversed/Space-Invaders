local systems = script.Parent.systems

for _, system in systems:GetChildren() do
	require(system)
end
