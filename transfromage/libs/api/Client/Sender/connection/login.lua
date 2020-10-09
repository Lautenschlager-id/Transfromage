local Client = require("api/Client/init")

local ByteArray = require("classes/ByteArray")
local encode = require("transfromage/utils/encoding")
local enum = require("api/enum")

------------------------------------------- Optimization -------------------------------------------
local bit_bxor           = bit.bxor
local encode_loginCipher = encode.loginCipher
local encode_password    = encode.password
local enum_error         = enum.error
local enum_errorLevel    = enum.errorLevel
local enum_timers        = enum.timers
local error              = error
local string_toNickname  = string.toNickname
local timer_setTimeout   = require("timer").setTimeout
local tostring           = tostring
----------------------------------------------------------------------------------------------------

local identifier = enum.identifier.loginSend

local triggerConnectionFailed = function(self)
	if not self.event.handlers.connectionFailed then
		return error(enum_error.failLogin, enum_errorLevel.low)
	end

	--[[@
		@name connectionFailed
		@desc Triggered when it fails to login.
	]]
	self.event:emit("connectionFailed")
end

local checkConnection = function(self)
	if not self._isConnected then
		self:disconnect()
		-- This timer prevents the time out issue, since it gives time to closeAll work.
		timer_setTimeout(enum_timers.triggerFailLogin, triggerConnectionFailed, self)
	end
end

--[[@
	@name connect
	@desc Connects to an account in-game.
	@desc It will try to connect using all the available ports before throwing a timing out error.
	@param userName<string> The name of the account. It must contain the discriminator tag (#).
	@param userPassword<string> The password of the account.
	@param startRoom?<string> The name of the initial room. @default "*#bolodefchoco"
	@param timeout<int> The time in ms to throw a timeout error if the connection takes too long to succeed. @default 20000
]]
Client.connect = function(self, userName, userPassword, startRoom, timeout)
	userName = string_toNickname(userName, true)

	local packet = ByteArray:new()
		:writeUTF(userName)
		:writeUTF(encode_password(userPassword))
		:writeUTF("app:/TransformiceAIR.swf/[[DYNAMIC]]/2/[[DYNAMIC]]/4")
		:writeUTF((startRoom and tostring(startRoom)) or "*#bolodefchoco")
	if not self._isOfficialBot then
		packet:write32(bit_bxor(self._authenticationKey, self._gameConnectionKey))
	end
	packet:write8(0):writeUTF('')
	if not self._isOfficialBot then
		packet = encode_loginCipher(packet, self._identificationKeys)
	end
	packet:write8(0)

	self.playerName = userName
	self.mainConnection:send(identifier, packet)

	timer_setTimeout((timeout or (20 * 1000)), checkConnection, self)
end