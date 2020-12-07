local filename = ...
local contained_by = {}
local graph = {}

for line in io.lines(filename) do
	local outer, contents = line:match "^(.-) bags contain (.+)$"
	if outer == nil then break end
	graph[outer] = graph[outer] or {}
	
	if(contents == "no other bags.") then
	else
		for content in contents:gmatch "%s*(%P+)" do
			local count, inner = content:match "(%d+)%s+(.*) bags?"
			contained_by[inner] = contained_by[inner] or {}
			table.insert(contained_by[inner], outer)
			
			graph[outer][inner] = count
		end
	end
end

local count = 0
local bags = {}
function find_roots(inner)
	for _, bag in pairs(contained_by[inner] or {}) do
		if not bags[bag] then
			bags[bag] = true
			count = count + 1
			find_roots(bag)
		end
	end
end

find_roots('shiny gold')
print("outer bags: "..count)

function subgraph_size(outer)
	local sum = 1
	for inner, count in pairs(graph[outer]) do
		sum = sum + count*subgraph_size(inner)
	end
	
	return sum
end

local total = subgraph_size('shiny gold') - 1
print("total bags: "..total)
