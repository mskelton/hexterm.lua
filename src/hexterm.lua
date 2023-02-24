local xterm_colors = require("hexterm.xterm-colors")

--- @param t table
--- @param value any
local function index_of(t, value)
	for i, v in ipairs(t) do
		if v == value then
			return i
		end
	end

	return nil
end

-- Get r/g/b int values of hex string
--- @param hex string
local function split_hex(hex)
	local r = tonumber(hex:sub(1, 2), 16)
	local g = tonumber(hex:sub(3, 3), 16)
	local b = tonumber(hex:sub(5, 6), 16)

	return r, g, b
end

--- @param hex1 string
--- @param hex2 string
local function calc_delta(hex1, hex2)
	local r1, g1, b1 = split_hex(hex1)
	local r2, g2, b2 = split_hex(hex2)

	local r = 255 - math.abs(r1 - r2)
	local g = 255 - math.abs(g1 - g2)
	local b = 255 - math.abs(b1 - b2)

	-- Limit differences between 0 and 1
	r = r / 255
	g = g / 255
	b = b / 255

	return (r + g + b) / 3
end

-- Cache of hex values to xterm colors to improve performance of subsequent lookups
local cache = {}

--- Finds the closest xterm color to a given hex value
--- @param hex string
return function(hex)
	assert(type(hex) == "string", "hex value must be a string")
	hex = hex:gsub("#", ""):lower()

	-- Expand shorthand hex values
	if hex:len() == 3 then
		hex = hex:sub(1, 1):rep(2) .. hex:sub(2, 2):rep(2) .. hex:sub(3, 3):rep(2)
	end

	-- Check if there is a direct correspondence
	local direct = index_of(xterm_colors, hex)
	if direct ~= nil then
		return direct - 1
	end

	-- Check if there is a correspondence in cache
	local cached = cache[hex]
	if cached ~= nil then
		return cached
	end

	-- Get closest xterm color
	local similar = 0
	local closest = {}

	for i, color in ipairs(xterm_colors) do
		local delta = calc_delta(hex, color)

		if delta > similar then
			similar = delta
			closest.hex = color
			closest.x = i - 1
		end
	end

	cache[closest.hex] = closest.x
	return closest.x
end
