local lu = require("luaunit")
local hexterm = require("hexterm")

function TestMissingHash()
	lu.assertEquals(hexterm("000000"), 0)
	lu.assertEquals(hexterm("ffffff"), 15)
end

function TestThreeDigit()
	lu.assertEquals(hexterm("#fff"), hexterm("#ffffff"))
	lu.assertEquals(hexterm("#000"), hexterm("#000000"))
	lu.assertEquals(hexterm("#fa3"), hexterm("#ffaa33"))
end

function TestStandardColors()
	lu.assertEquals(hexterm("#000000"), 0)
	lu.assertEquals(hexterm("#ffffff"), 15)
	lu.assertEquals(hexterm("#ffaa33"), 215)
	lu.assertEquals(hexterm("#78909c"), 246)
end

os.exit(lu.LuaUnit.run())
