-- There must be a regular player in the room in order to make this test pass.

local timer = require("timer")

require("wrapper")(function(test, transfromage, client, _, clientAux)
	-- if not client.room.isTribeHouse then
	test("join tribe house", function(expect)
		client:on("joinTribeHouse", expect(function(roomName, roomLanguage)
			p("Received event joinTribeHouse")

			assert(roomName)
			assert(roomLanguage)
		end))

		p("Joining tribe house")
		timer.setTimeout(3500, client.joinTribeHouse, client)

		return -8500
	end)
	--end

	test("get cheese and hole", function(expect)
		client:once("playerGetCheese", expect(function(playerData, hasCheese)
			p("Received event playerGetCheese")

			assert_eq(tostring(playerData), "Player", "str(t)")
			assert_eq(type(hasCheese), "boolean", "type(hasCheese)")

			assert_eq(playerData.hasCheese, hasCheese, "t.hasCheese")
			assert_eq(playerData.winPosition, -1, "t.winPosition")
			assert_eq(playerData.winTimeElapsed, -1, "t.winTimeElapsed")
			assert_eq(playerData.hasWon, false, "t.hasWon")
		end))

		client:once("playerWon", expect(function(playerData, winPosition, winTimeElapsed)
			p("Received event playerWon")

			assert_eq(tostring(playerData), "Player", "str(t)")
			assert_eq(type(winPosition), "number", "type(winPosition)")
			assert_eq(type(winTimeElapsed), "number", "type(winTimeElapsed)")


			assert_eq(playerData.hasCheese, true, "t.hasCheese")
			assert_neq(playerData.winPosition, -1, "t.winPosition")
			assert_neq(playerData.winTimeElapsed, -1, "t.winTimeElapsed")
			assert_eq(playerData.hasWon, true, "t.hasWon")
		end))

		timer.setTimeout(5000, client.sendCommand, client, "np @6264090")

		return -11700 -- The map has a ground that disappears after 6700ms
	end)
end)