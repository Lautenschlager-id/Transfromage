------------------------------------------- Optimization -------------------------------------------
local require = require
----------------------------------------------------------------------------------------------------

-- Checks for API updates
local APIVersion = require("./update")

-- Initializes all extensions
require("utils/extensions")

return {
	version = APIVersion,

	Client = require("api/Client"),
	ByteArray = require("classes/ByteArray"),
	Translation = require("classes/Translation"),

	enum = require("api/enum"),
	encode = require("utils/encode")
}