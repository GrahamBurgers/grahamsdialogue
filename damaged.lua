function damage_received( damage, message, entity_thats_responsible, is_fatal)
    local x, y = EntityGetTransform(GetUpdatedEntityID())
    if damage > 0 and EntityHasTag(entity_thats_responsible, "player_unit") and not is_fatal and entity_thats_responsible ~= GetUpdatedEntityID() then
        SetRandomSeed(entity_thats_responsible + GameGetFrameNum() + y, damage + 1394 + x)

        local rate = math.floor(tonumber(ModSettingGet("grahamsdialogue.damaged")) + 0.5)
        if rate < 1 then return end
        if Random(1, rate) == 1 then
            local name = EntityGetName(GetUpdatedEntityID())
            if name == nil then return end
            name = name:gsub("_weak", "")
            dofile_once("mods/grahamsdialogue/common.lua")
            for i = 1, #DIALOGUE_DAMAGETAKEN do
                if GameTextGetTranslatedOrNot(DIALOGUE_DAMAGETAKEN[i][1]) == GameTextGetTranslatedOrNot(name) then
                    local type = Random(2, #DIALOGUE_DAMAGETAKEN[i])
                    Speak(GetUpdatedEntityID(), tostring(DIALOGUE_DAMAGETAKEN[i][type]), "DAMAGETAKEN")
                    break
                end
            end
        end
    end
end