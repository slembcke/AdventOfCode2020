loadfile "../common.lua"

filename = ...
f = io.open(filename)

jolts = {}
for line in f:lines() do table.insert(jolts, tonumber(line)) end

table.sort(jolts)

-- Part 1
-- local diff1, diff3 = 1, 1
-- for i = 2, #jolts do
-- 	local diff = jolts[i] - jolts[i - 1]
-- 	if diff == 1 then diff1 = diff1 + 1 end
-- 	if diff == 3 then diff3 = diff3 + 1 end
-- end
-- print(diff1*diff3)

local tmp, sums = {table.remove(jolts)}, {1}
function push(jolt)
	local sum = 0
	for i = 1, #tmp do
		if tmp[i] > jolt + 3 then break end
		
		sum = sum + sums[i]
	end
	
	table.insert(tmp, 1, jolt)
	table.insert(sums, 1, sum)
end

while #jolts > 0 do
	push(table.remove(jolts))
end
-- AURGH! I FORGOT ABOUT 0 FOR LIKE 30 MINUTES
push(0)

print(sums[1])
