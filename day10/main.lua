loadfile "../common.lua"

filename = ...
f = io.open(filename)

-- dbg = require 'debugger'

jolts = {}
for line in f:lines() do table.insert(jolts, tonumber(line)) end

table.sort(jolts)
local diff1, diff3 = 1, 1
for i = 2, #jolts do
	local diff = jolts[i] - jolts[i - 1]
	if diff == 1 then diff1 = diff1 + 1 end
	if diff == 3 then diff3 = diff3 + 1 end
end

print(diff1*diff3)

local count = 0
local sols = {}
function chain_rec(idx0, jolt, sol)
	if idx0 > #jolts then
		-- print("solution", sol.." "..jolt)
		count = count + 1
		return
	end
	
	for i = idx0, #jolts do
		if jolts[i] > jolt + 3 then break end
		
		chain_rec(i + 1, jolts[i], 0 --[[sol.." "..jolt]])
	end
end

-- dbg.call(function()
chain_rec(1, 0, "")
print(count)
-- end)
