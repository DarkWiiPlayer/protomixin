--- Resolves a missing key in a table to one of its mixins (in order)
local function resolve(tab, key)
	local mt = getmetatable(tab)
	for i=mt.mixins,1,-1 do
		if mt[i][key] then
			return mt[i][key]
		end
	end
end

--- Adds a new mixin to an object.
-- Creates the object if it's nil.
local function new(mixin, target)
	target = target or {}
	if type(target)~="table" then
		error("Attempting to add mixin to non-table type: "..type(target), 2)
	end

	local mt = getmetatable(target)
	if not mt then
		mt = {}
		setmetatable(target, mt)
	end

	mt.mixins = (mt.mixins or 0) + 1
	mt[mt.mixins] = mixin
	-- TODO: check for existing and warn/error
	mt.__index=resolve;
	mt.__call=new;

	return target
end

return { new=new, resolve=resolve }
