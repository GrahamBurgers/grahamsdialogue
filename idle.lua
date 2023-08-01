if #EntityGetWithTag("player_unit") < 1 then return end -- don't speak when there's no player
local me = GetUpdatedEntityID()
local x, y = EntityGetTransform(me)
SetRandomSeed(x + GameGetFrameNum(), y + 1394)
local rate = math.floor(tonumber(ModSettingGet("grahamsdialogue.idle")) + 0.5)
if rate < 1 then return end
if Random(1, rate) == 1 then
    local worldstatecomp = EntityGetFirstComponent(GameGetWorldStateEntity(), "WorldStateComponent") or 0
    local inventory = EntityGetFirstComponent(me, "Inventory2Component") or 0
    local wand = ComponentGetValue2(inventory, "mActiveItem") or 0
    local random = Random(1, 10)
    -- this is a sort of priority system; hopefully this many elseifs won't cause problems
    dofile_once("mods/grahamsdialogue/common.lua")
    if GameGetGameEffectCount(me, "ON_FIRE") > 0 then -- on fire
        Speak(me, GENERIC_ONFIRE[Random(1, #GENERIC_ONFIRE)], "GENERIC")
        return
    elseif random <= 5 and ComponentGetValue2(worldstatecomp, "ENDING_HAPPINESS") then -- peaceful ending
        Speak(me, GENERIC_PEACEFULENDING[Random(1, #GENERIC_PEACEFULENDING)], "GENERIC")
        return
    elseif random <= 8 and wand ~= 0 and EntityHasTag(wand, "wand") then -- holding wand
        Speak(me, GENERIC_HOLDINGWAND[Random(1, #GENERIC_HOLDINGWAND)], "GENERIC")
        return
    elseif random <= 4 and GameGetGameEffectCount(me, "DRUNK") > 0 then -- drunk (both ingestion and alcohol stain)
        Speak(me, GENERIC_DRUNK[Random(1, #GENERIC_DRUNK)], "GENERIC")
        return
    elseif random <= 8 and GameGetGameEffectCount(me, "BERSERK") > 0 then -- berserk
        Speak(me, GENERIC_BERSERK[Random(1, #GENERIC_BERSERK)], "GENERIC")
        return
    elseif random <= 6 and GameGetGameEffectCount(me, "CHARM") > 0 then -- charmed
        Speak(me, GENERIC_CHARMED[Random(1, #GENERIC_CHARMED)], "GENERIC")
        return
    elseif random <= 9 and GameGetGameEffectCount(me, "RADIOACTIVE") > 0 then -- toxic
        Speak(me, GENERIC_TOXIC[Random(1, #GENERIC_TOXIC)], "GENERIC")
        return
    elseif random <= 9 and GameGetGameEffectCount(me, "CONFUSION") > 0 then -- confused
        Speak(me, GENERIC_CONFUSED[Random(1, #GENERIC_CONFUSED)], "GENERIC")
        return
    end

    local name = EntityGetName(me)
    for i = 1, #DIALOGUE_IDLE do
        if GameTextGetTranslatedOrNot(name) == GameTextGetTranslatedOrNot(DIALOGUE_IDLE[i][1]) then
            if Random(1, 100000) == 100000 then
                Speak(me, "Robin was a fool.", "IDLE")
            else
                local type = Random(2, #DIALOGUE_IDLE[i])
                Speak(me, tostring(DIALOGUE_IDLE[i][type]), "IDLE")
            end
            break
        end
    end
end