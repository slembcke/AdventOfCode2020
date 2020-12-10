function fold_range(list, idx0, idx1, func, seed)
	for i = idx0, idx1 do seed = func(seed, list[i]) end
	return seed
end

function table.copy(table)
	local copy = {}
	for k, v in pairs(table) do copy[k] = v end
	return copy
end
