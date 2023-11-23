--dofile("mods/grahamsdialogue/files/common.lua")
function damage_received(damage, message, entity_thats_responsible, is_fatal)
	local me = GetUpdatedEntityID()
	local x, y = EntityGetTransform(me)
	dofile_once("mods/grahamsdialogue/files/common.lua")
	if entity_thats_responsible ~= me and EntityHasTag(entity_thats_responsible, "mortal") and not EntityHasGameEffect(me, { "PROTECTION_ALL" }) then
		SetRandomSeed(entity_thats_responsible + y, me + GameGetFrameNum() + x)

		local rate = math.floor(tonumber(ModSettingGet("grahamsdialogue.damaged")) + 0.5)
		if ModSettingGet("grahamsdialogue.damaged_enabled") == false then return end
		if IsBoss(me) then return end
		if Random(1, rate) == 1 then
			if damage > 0 then
				if EntityHasTag(entity_thats_responsible, "player_unit") then
					local name = NameGet(me)
					for i = 1, #DIALOGUE_DAMAGETAKEN do
						if DIALOGUE_DAMAGETAKEN[i][1] == name then
							Speak(me, GetLine(DIALOGUE_DAMAGETAKEN, i, pools.DAMAGETAKEN), pools.DAMAGETAKEN)
							break
						end
					end
				else
					Speak(me, GetLineGeneric(GENERIC_FRIENDLYFIRE, "GENERIC_FRIENDLYFIRE"), pools.GENERIC)
				end
			elseif damage < 0 then
				Speak(me, GetLineGeneric(GENERIC_HEALED, "GENERIC_HEALED"), pools.GENERIC)
			end
		end
	end
end
