local BITS = {byr = 0x01, iyr = 0x02, eyr = 0x04, hgt = 0x08, hcl = 0x10, ecl = 0x20, pid = 0x40}

local VALIDATIONS = {}

function VALIDATIONS.byr(value)
	local n = tonumber(value)
	return n and 1920 <= n and n <=2002
end

function VALIDATIONS.iyr(value)
	local n = tonumber(value)
	return n and 2010 <= n and n <=2020
end

function VALIDATIONS.eyr(value)
	local n = tonumber(value)
	return n and 2020 <= n and n <=2030
end

function VALIDATIONS.hgt(value)
	local val, unit = value:match "^(%d*)(%w%w)$"
	local n = tonumber(val)
	if unit == "cm" then
		return n and 150 <= n and n <= 193
	elseif unit == "in" then
		return n and 59 <= n and n <= 76
	else
		return false
	end
end

function VALIDATIONS.hcl(value)
	return value:match "^#[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]$"
end

local EYE_COLORS = {amb = true, blu = true, brn = true, gry = true, grn = true, hzl = true, oth = true}
function VALIDATIONS.ecl(value)
	return EYE_COLORS[value]
end

function VALIDATIONS.pid(value)
	return value:match "^%d%d%d%d%d%d%d%d%d$"
end

function validate(f)
	local bits = 0

	while true do
		local str = f:read()
		if(str == nil) then return nil end
		if(str == "") then break end
		
		while str ~= "" do
			local key, value, rem = str:match "(%w*):(%S*)(.*)"
			local validation = VALIDATIONS[key]
			if validation and validation(value) then
				bits = bits | (BITS[key] or 0)
			end
			str = rem
		end
	end
	
	return bits == 0x7F
end

local filename = ...
local f = io.open(filename)

local valid_count = 0
while true do
	local valid = validate(f)
	if(valid == nil) then break end
	
	if(valid) then valid_count = valid_count + 1 end
end

print(valid_count)
