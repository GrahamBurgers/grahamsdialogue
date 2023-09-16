---@diagnostic disable-next-line: lowercase-global
function damage_received( damage, message, entity_thats_responsible, is_fatal)
    local me = GetUpdatedEntityID()
    local x, y = EntityGetTransform(me)
    if entity_thats_responsible ~= me and EntityHasTag(entity_thats_responsible, "mortal") then
        SetRandomSeed(entity_thats_responsible + me + y, damage + 1394 + x)

        local rate = math.floor(tonumber(ModSettingGet("grahamsdialogue.damaged")) + 0.5)
        if ModSettingGet("grahamsdialogue.damaged_enabled") == false then return end
        if Random(1, rate) == 1 then
            dofile_once("mods/grahamsdialogue/files/common.lua")
            if damage > 0 and EntityHasTag(entity_thats_responsible, "player_unit") then
                local name = NameGet(me)
                for i = 1, #DIALOGUE_DAMAGETAKEN do
                    if DIALOGUE_DAMAGETAKEN[i][1] == name then
                        local type = Random(2, #DIALOGUE_DAMAGETAKEN[i])
                        Speak(me, tostring(DIALOGUE_DAMAGETAKEN[i][type]), "DAMAGETAKEN")
                        break
                    end
                end
            elseif damage < 0 then
                Speak(me, GENERIC_HEALED[Random(1, #GENERIC_HEALED)], "GENERIC")
            end
        end
    end
end