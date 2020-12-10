filename, preamble = ...
f = io.open(filename)
preamble = tonumber(preamble)

queue = {}
numbers = {}

for i = 1, preamble do
	local n = tonumber(f:read())
	table.insert(queue, n)
	table.insert(numbers, n)
end

function find_pair(n)
	for i = 1, #queue do
		for j = i + 1, #queue do
			if(queue[i] + queue[j] == n) then
				return true
			end
		end
	end
	
	return false
end

function add_min_max(i, j)
	local min, max = numbers[i], numbers[i]
	for k = i, j do
		min = math.min(min, numbers[k])
		max = math.max(max, numbers[k])
	end
	
	print("min + max", min + max)
end

function find_range(n)
	for i = 1, #numbers do
		local sum = 0
		for j = i, #numbers do
			sum = sum + numbers[j]
			if sum == n then
				print("range", i, j)
				add_min_max(i, j)
				return
			end
			
			if sum > n then break end
		end
	end
	print("not found")
end

for line in f:lines() do
	local n = tonumber(line)
	if not find_pair(n) then
		print("n", n)
		find_range(n)
		break
	end
	
	table.remove(queue, 1)
	table.insert(queue, n)
	table.insert(numbers, n)
end
