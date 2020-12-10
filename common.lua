function fold_range(list, idx0, idx1, func, seed)
	for i = idx0, idx1 do seed = func(seed, list[i]) end
	return seed
end
