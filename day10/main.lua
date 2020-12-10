loadfile "../common.lua"

filename = ...
f = io.open(filename)

jolts = {}
for line in f:lines() do table.insert(jolts, tonumber(line)) end

table.sort(jolts)

local diff1, diff3 = 1, 1
for i = 2, #jolts do
	local diff = jolts[i] - jolts[i - 1]
	if diff == 1 then diff1 = diff1 + 1 end
	if diff == 3 then diff3 = diff3 + 1 end
end
print("part 1", diff1*diff3)

local tmp, sums = {table.remove(jolts)}, {1}
function add_jolt(jolt)
	-- Sum the values in range of this adapter.
	local sum = 0
	for i = 1, #tmp do
		if tmp[i] > jolt + 3 then break end
		sum = sum + sums[i]
	end
	
	-- Memorize the solution.
	table.insert(tmp, 1, jolt)
	table.insert(sums, 1, sum)
end

-- Rebuild the list in reverse order, memorizing as it goes.
while #jolts > 0 do
	add_jolt(table.remove(jolts))
end
-- AURGH! I FORGOT ABOUT 0 FOR LIKE 30 MINUTES
add_jolt(0)

print("part 2", sums[1])
