local uv = require("uv")

local timer_setTimeout = require("timer").setTimeout

local killConnections = require("api/Client/utils/killConnections")

-- Optimization --
local os_exit = os.exit
local uv_signal_start = uv.signal_start
local uv_new_signal = uv.new_signal
------------------

local clients, totalClients = { }, 0

local isKillingProcess = false
local killProcess = function()
	if isKillingProcess then return end
	isKillingProcess = true

	for c = 1, totalClients do
		killConnections(clients[c])
	end

	timer_setTimeout(100, os_exit)
end

local isListeningSigterm = false
local killOnSigterm = function(client)
	if isListeningSigint then
		-- Adds new client to the list
		totalClients = totalClients + 1
		client[totalClients] = client
		return
	end
	isListeningSigint = true

	uv_signal_start(uv_new_signal(), "sigint", killProcess)
	uv_signal_start(uv_new_signal(), "sighup", killProcess)
end

return killOnSigterm