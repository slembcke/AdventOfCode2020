dbg = require 'debugger'
dbg.call(function()

list = {}
for line in io.lines("day01.input") do
	table.insert(list, tonumber(line))
end

function find2(list)
	for _, a in ipairs(list) do
		for _, b in ipairs(list) do
			if a + b == 2020 then
				print(a*b)
				return
			end
		end
	end
end
find2(list)

function find3(list)
	for _, a in ipairs(list) do
		for _, b in ipairs(list) do
			for _, c in ipairs(list) do
				if a + b + c == 2020 then
					print(a*b*c)
					return
				end
			end
		end
	end
end
find3(list)

end)