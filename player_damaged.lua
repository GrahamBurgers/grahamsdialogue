function damage_received( damage, message, entity_thats_responsible, is_fatal)
    if entity_thats_responsible ~= 0 and entity_thats_responsible ~= nil and entity_thats_responsible ~= GetUpdatedEntityID() then
        SetRandomSeed(entity_thats_responsible + GameGetFrameNum(), damage + 3141)

        local rate = math.floor(tonumber(ModSettingGet("grahamsdialogue.damaging")) + 0.5)
        if rate == 20 then return end
        if Random(1, rate) == 1 then
            local name = EntityGetName(entity_thats_responsible)
            if name == nil then return end
            name = name:gsub("_weak", "")
            dofile_once("mods/grahamsdialogue/common.lua")
            for i = 1, #DIALOGUE_DAMAGEDEALT do
                if DIALOGUE_DAMAGEDEALT[i][1] == name then
                    local type = Random(2, #DIALOGUE_DAMAGEDEALT[i])
                    Speak(entity_thats_responsible, tostring(DIALOGUE_DAMAGEDEALT[i][type]), "DAMAGEDEALT")
                    break
                end
            end
        end
    end
end