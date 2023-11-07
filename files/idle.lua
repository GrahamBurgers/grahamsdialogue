---@diagnostic disable: undefined-global, lowercase-global
local me = GetUpdatedEntityID()
local x, y = EntityGetTransform(me)
SetRandomSeed(x + GameGetFrameNum(), y + 1394)
local rate = math.floor(tonumber(ModSettingGet("grahamsdialogue.idle")) + 0.5)
if ModSettingGet("grahamsdialogue.idle_enabled") == false then return end
if Random(1, rate) == 1 then
    dofile_once("mods/grahamsdialogue/files/common.lua")
    local worldstatecomp = EntityGetFirstComponent(GameGetWorldStateEntity(), "WorldStateComponent") or 0
    local inventory = EntityGetFirstComponent(me, "Inventory2Component") or 0
    local wand = ComponentGetValue2(inventory, "mActiveItem") or 0
    local random = Random(1, 10)
    -- this is a sort of priority system; hopefully this many elseifs won't cause problems
    if not (EntityHasTag(me, "no_generic_dialogue") or NameGet(me) == "$animal_playerghost") then
        if GameGetGameEffectCount(me, "ON_FIRE") > 0 then -- on fire
            Speak(me, GENERIC_ONFIRE[Random(1, #GENERIC_ONFIRE)], "GENERIC")
            return
        elseif random <= 5 and ComponentGetValue2(worldstatecomp, "ENDING_HAPPINESS") then -- peaceful ending
            Speak(me, GENERIC_PEACEFULENDING[Random(1, #GENERIC_PEACEFULENDING)], "GENERIC")
            return
        elseif random <= 6 and wand ~= 0 and EntityHasTag(wand, "wand") then -- holding wand
            Speak(me, GENERIC_HOLDINGWAND[Random(1, #GENERIC_HOLDINGWAND)], "GENERIC")
            return
        elseif random <= 4 and GameGetGameEffectCount(me, "DRUNK") > 0 then -- drunk (both ingestion and alcohol stain)
            Speak(me, GENERIC_DRUNK[Random(1, #GENERIC_DRUNK)], "GENERIC")
            return
        elseif random <= 7 and GameGetGameEffectCount(me, "BERSERK") > 0 then -- berserk
            Speak(me, GENERIC_BERSERK[Random(1, #GENERIC_BERSERK)], "GENERIC")
            return
        elseif random <= 9 and GameGetGameEffectCount(me, "CHARM") > 0 then -- charmed
            Speak(me, GENERIC_CHARMED[Random(1, #GENERIC_CHARMED)], "GENERIC")
            return
        elseif random <= 4 and GameGetGameEffectCount(me, "RADIOACTIVE") > 0 then -- toxic
            Speak(me, GENERIC_TOXIC[Random(1, #GENERIC_TOXIC)], "GENERIC")
            return
        end
    end

    local name = NameGet(me)
    for i = 1, #DIALOGUE_IDLE do
        if DIALOGUE_IDLE[i][1] == name then
            local type = Random(2, #DIALOGUE_IDLE[i])
            Speak(me, tostring(DIALOGUE_IDLE[i][type]), "IDLE")
            break
        end
    end
end