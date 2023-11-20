---@diagnostic disable: undefined-global, lowercase-global
local me = GetUpdatedEntityID()
local x, y = EntityGetTransform(me)
SetRandomSeed(x + GameGetFrameNum(), y + me + 23835)
local rate = math.floor(tonumber(ModSettingGet("grahamsdialogue.idle")) + 0.5)
if ModSettingGet("grahamsdialogue.idle_enabled") == false then return end
if Random(1, rate) == 1 and Random(1, 2) == 1 then                                   -- make these guys speak half as often to not annoy the player
	dofile_once("mods/grahamsdialogue/files/common.lua")
	local id = ComponentGetValue2(GetUpdatedComponentID(), "script_polymorphing_to") -- I don't feel like using a VariableStorageComponent
	for i = 1, #Custom_speak_lines do
		if Custom_speak_lines[i][1] == id then
			local who = EntityGetAllChildren(me)
			if who ~= nil then me = who[1] end
			local type = Random(2, #Custom_speak_lines[i])
			Speak(me, GetLine(Custom_speak_lines, i, pools.CUSTOM), pools.CUSTOM, true, false, id)
			break
		end
	end
end
