--dofile("mods/grahamsdialogue/files/common.lua")

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	local x, y = EntityGetTransform(GetUpdatedEntityID())
	SetRandomSeed(entity_thats_responsible + GameGetFrameNum() + x, y + 3141)
	local enemies = EntityGetInRadiusWithTag(x, y, 70, "hittable")
	dofile_once("mods/grahamsdialogue/files/common.lua")
	for p = 1, 2 do -- hax?
		for i = 1, #enemies do
			if not EntityHasTag(enemies[i], "enemy") or entity_thats_responsible == enemies[i] or Random(1, 4) == 1 then
				local name = NameGet(enemies[i])
				for j = 1, #DIALOGUE_DEATH do
					if DIALOGUE_DEATH[j][1] == name then
						local line = GetLine(DIALOGUE_DEATH, j, pools.DEATH)
						Speak(enemies[i], line, pools.DEATH, true, true)
						break
					end
				end
			end
		end
		enemies = EntityGetInRadiusWithTag(x, y, 70, "graham_enemydialogue")
	end
end
