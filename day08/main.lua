local filename = ...

local opcodes, args = {}, {}
for line in io.lines(filename) do
	local op, arg = line:match "(%w*) ([+-]%w*)"
	if op then
		table.insert(opcodes, op)
		table.insert(args, tonumber(arg))
	end
end

function execute()
	local ip, acc = 1, 0

	local dispatch = {
		nop = function(arg) ip = ip + 1 end,
		acc = function(arg) acc, ip = acc + arg, ip + 1 end,
		jmp = function(arg) ip = ip + arg end,
	}
	
	local access = {}
	while ip <= #opcodes and not access[ip] do
		access[ip] = true
		local op, arg = opcodes[ip], args[ip]
		dispatch[op](arg)
	end
	
	return ip, acc
end

local sub = {nop = "jmp", jmp = "nop", acc = "acc"}
for i = 1, #opcodes do
	local op = opcodes[i]
	opcodes[i] = sub[op]
	
	local ip, acc = execute()
	if ip == #opcodes + 1 then
		print("clean exit", ip, acc)
	end
	
	opcodes[i] = op
end
