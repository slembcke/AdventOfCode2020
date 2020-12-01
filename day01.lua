dbg = require 'debugger'

dbg.call(function()

list = {}
for line in io.lines("day01.txt") do
	table.insert(list, tonumber(line))
end

for i = 1, #list do
	for j = 1, #list do
		if list[i] + list[j] == 2020 then
			print(list[i]*list[j])
			return
		end
	end
end

end)