--dofile("mods/grahamsdialogue/files/common.lua")

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	local me = GetUpdatedEntityID()
	local x, y = EntityGetTransform(me)
	SetRandomSeed(entity_thats_responsible + GameGetFrameNum() + x, y + 3141)
	local enemies = EntityGetInRadius(x, y, 140)
	dofile_once("mods/grahamsdialogue/files/common.lua")
	for p = 1, 2 do -- hax?
		for i = 1, #enemies do
			if (entity_thats_responsible == enemies[i]) or (EntityGetHerdRelation(me, enemies[i]) > 75) or (not EntityHasTag(enemies[i], "enemy")) then
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