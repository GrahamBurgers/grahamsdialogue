dofile("mods/grahamsdialogue/files/dialogue.lua")

DUPES = ({ -- for when multiple enemy translation entries are identical
    ["$animal_zombie_weak"]              = "$animal_zombie",
    ["$animal_shotgunner_weak"]          = "$animal_shotgunner",
    ["$animal_miner_weak"]               = "$animal_miner",
    ["$animal_slimeshooter_weak"]        = "$animal_slimeshooter",
    ["$animal_giantshooter_weak"]        = "$animal_giantshooter",
    ["$animal_acidshooter_weak"]         = "$animal_acidshooter",
    ["$animal_slimeshooter_nontoxic"]    = "$animal_slimeshooter",
    ["$animal_drone_physics"]            = "$animal_drone",
    ["$animal_turret_right"]             = "$animal_turret",
    ["$animal_turret_left"]              = "$animal_turret",
})

function NameGet(entity)
    local name = EntityGetName(entity) or ""
    if name == nil then return end
    name = DUPES[name] or name
    return name
end

function ModdedStuff()
    -- APPEND HERE! This function will be called right before dialogue is shown.
    -- See README_MODDERS.lua for more info
end

local special_offsets_y = ({ -- for when an enemy is taller or shorter than expected
    ["$animal_boss_alchemist"]        = 60,
    ["$animal_parallel_alchemist"]    = 60,
    ["$animal_boss_pit"]              = 15,
    ["$animal_parallel_tentacles"]    = 15,
    ["$animal_necromancer_shop"]      = 10,
    ["$animal_necromancer_super"]     = 12,
    ["$animal_firemage"]              = 8,
    ["$animal_thundermage"]           = 8,
    ["$animal_tentacler"]             = 10,
    ["$animal_giant"]                 = 8,
    ["$animal_pebble"]                = -4,
    ["$animal_rat"]                   = -2,
    ["$animal_drone"]                 = -10,
    ["$animal_scavenger_leader"]      = 10,
    ["$animal_scavenger_clusterbomb"] = 10,
    ["$animal_scavenger_mine"]        = 10,
    ["$animal_necromancer"]           = 12,
    ["$animal_worm_tiny"]             = -8,
    ["$animal_worm"]                  = -5,
    ["$animal_worm_big"]              = -2,
})

function EnemyHasDialogue(pool, name)
    local what = {}
    if pool == "IDLE" then what = DIALOGUE_IDLE end
    if pool == "DAMAGETAKEN" then what = DIALOGUE_DAMAGETAKEN end
    if pool == "DAMAGEDEALT" then what = DIALOGUE_DAMAGEDEALT end
    if what ~= {} then
        for i = 1, #what do
            if what[i][1] == name then return i end
        end
    end
    if pool == "ANY" then
        for i = 1, #DIALOGUE_IDLE do
            if DIALOGUE_IDLE[i][1] == name then return i end
        end
        for i = 1, #DIALOGUE_DAMAGETAKEN do
            if DIALOGUE_DAMAGETAKEN[i][1] == name then return i end
        end
        for i = 1, #DIALOGUE_DAMAGEDEALT do
            if DIALOGUE_DAMAGEDEALT[i][1] == name then return i end
        end
    end
    return false
end

function AddEnemyDialogue(pool, name, dialogue)
    local has = EnemyHasDialogue(pool, name)
    local what = {}
    if pool == "IDLE" then what = DIALOGUE_IDLE end
    if pool == "DAMAGETAKEN" then what = DIALOGUE_DAMAGETAKEN end
    if pool == "DAMAGEDEALT" then what = DIALOGUE_DAMAGEDEALT end
    if has then
        for j = 1, #dialogue do
            -- If the enemy exists in the table already, insert the new dialogue
            table.insert(what[has], dialogue[j])
        end
    else
        -- if the enemy isn't in the table already, put it in
        table.insert(dialogue, 1, name)
        table.insert(what, dialogue)
    end
    if pool == "IDLE" then DIALOGUE_IDLE = what end
    if pool == "DAMAGETAKEN" then DIALOGUE_DAMAGETAKEN = what end
    if pool == "DAMAGEDEALT" then DIALOGUE_DAMAGEDEALT = what end
end

function EmptyEnemyDialogue(pool, name)
    local has = EnemyHasDialogue(pool, name)
    local what = {}
    if pool == "IDLE" then what = DIALOGUE_IDLE end
    if pool == "DAMAGETAKEN" then what = DIALOGUE_DAMAGETAKEN end
    if pool == "DAMAGEDEALT" then what = DIALOGUE_DAMAGEDEALT end

    if has then
        table.remove(what, has)
    end

    if pool == "IDLE" then DIALOGUE_IDLE = what end
    if pool == "DAMAGETAKEN" then DIALOGUE_DAMAGETAKEN = what end
    if pool == "DAMAGEDEALT" then DIALOGUE_DAMAGEDEALT = what end
end

function Speak(entity, text, pool)
    pool = pool or ""
    local textComponent = EntityGetFirstComponentIncludingDisabled(entity, "SpriteComponent", "graham_speech_text")
    if textComponent then return end

    local rotate = false
    local old_text = text
    local x, y = EntityGetTransform(entity)
    SetRandomSeed(entity + x + 2352, GameGetFrameNum() - y + 24806)
    local size_x = 0.7
    local size_y = 0.7

    local alpha = (100 - ModSettingGet("grahamsdialogue.transparency")) / 100
    local name = NameGet(entity)
    local offset_y = 26 + (special_offsets_y[name] or 0)

    if not (EntityHasTag(entity, "graham_enemydialogue") or EnemyHasDialogue("ANY", name)) then return end

    --- SPECIAL FUNCTIONALITY ---

    -- Copier mage should go at the top, so it can pretend to be a different enemy
    if name == "$animal_wizard_returner" then
        local thing = nil
        if pool == "IDLE" then thing = DIALOGUE_IDLE end
        if pool == "DAMAGEDEALT" then thing = DIALOGUE_DAMAGEDEALT end
        if pool == "DAMAGETAKEN" then thing = DIALOGUE_DAMAGETAKEN end
        if thing ~= nil then
            local enemies = EntityGetInRadiusWithTag(x, y, 150, "enemy") or {}
            for j = 1, #enemies do
                local enemy = enemies[Random(1, #enemies)]
                name = EntityGetName(enemy)
                name = name:gsub("_weak", "")
                if name ~= "$animal_wizard_returner" then
                    for i = 1, #thing do
                        if thing[i][1] == name then
                            text = tostring(thing[i][Random(2, #thing[i])])
                            break
                        end
                    end
                end
                if text ~= old_text then break end
            end
        end
    end

    if GameHasFlagRun("PERK_PICKED_PEACE_WITH_GODS") and (pool == "IDLE" or pool == "GENERIC") then
        if name == "$animal_necromancer_shop" then
            local special = {
                "I suppose I can let it slide. But just this once!",
                "Don't think that this means that you're off the hook...",
                "Fine... harumph.",
            }
            text = special[Random(1, #special)]
        end
        if name == "$animal_necromancer_super" then
            local special = {
                "A sinful being you are... But perhaps a little bit endearing.",
                "Don't be mistaken. It is by command of the gods that I spare your life today.",
                "I'm sure you have your reasons. But so do I.",
            }
            text = special[Random(1, #special)]
        end
    end

    if (name == "$animal_firemage" or name == "$animal_thundermage") and pool == "IDLE" then
        local items = EntityGetInRadiusWithTag(x, y, 180, "item_pickup")
        for i = 1, #items do
            if EntityGetRootEntity(items[i]) ~= items[i] then
                if text ~= old_text then break end
                local comps = EntityGetComponent(items[i], "GameEffectComponent", "enabled_in_hand") or {}
                for j = 1, #comps do
                    if ComponentGetValue2(comps[j], "effect") == "FRIEND_FIREMAGE" and name == "$animal_firemage" or name == "$animal_firemage_weak" then
                        local special = {
                            "Nice stone you got there. Is it for sale?",
                            "That flame... it reminds me of myself when I was younger.",
                            "Come a bit closer. I'd like to get a closer look at that item.",
                        }
                        text = special[Random(1, #special)]
                        break
                    end
                    if ComponentGetValue2(comps[j], "effect") == "FRIEND_THUNDERMAGE" and name == "$animal_thundermage" then
                        local special = {
                            "What a beautiful stone. Take good care of it.",
                            "It looks like you appreciate the art of electricity almost as much as I do.",
                            "I would normally blast you to pieces, but...",
                        }
                        text = special[Random(1, #special)]
                        break
                    end
                end
            end
        end
    end

    if name == "$animal_thunderskull" and (pool == "DAMAGEDEALT" or pool == "DAMAGETAKEN") and GameHasFlagRun("PERK_PICKED_ELECTRICITY") then
        local special = {
            "Yo! A fellow electricity user?!",
            "I never expected to see someone as rad as me down here!",
            "I'm a fan of the volts you're outputting, friend.",
        }
        text = special[Random(1, #special)]
    end
    if name == "$animal_iceskull" and (pool == "DAMAGEDEALT" or pool == "DAMAGETAKEN") and GameHasFlagRun("PERK_PICKED_GRAHAM_REVENGE_FREEZE") then
        local special = {
            "Hey, you also have retaliation projectiles? N-ice.",
            "Your perks are cool! And I mean that literally.",
            "We should make some ice sculptures together, some time.",
        }
        text = special[Random(1, #special)]
    end

    if name == "$animal_giant" then
        local enemies = EntityGetInRadiusWithTag(x, y, 140, "glue_NOT")
        for i = 1, #enemies do
            if EntityGetName(enemies[i]) == "$animal_pebble" then
                Speak(enemies[i], text, pool)
            end
        end
    end

    local genome = EntityGetFirstComponent(entity, "GenomeDataComponent")
    if genome ~= nil then
        local faction = HerdIdToString(ComponentGetValue2(genome, "herd_id"))
        if faction == "robot" then
            size_x = size_x + 0.06
        end
        if faction == "fungus" then
            size_y = size_y + 0.06
        end
        if faction == "player" then
            size_x = size_x + 0.03
            size_y = size_y + 0.03
        end
    end
    if name == "$animal_pebble" or name == "$animal_miniblob" then
        size_x = size_x - 0.10
        size_y = size_y - 0.10
    end

    local worm_speeds = {
        ["$animal_worm_tiny"]    = 4,
        ["$animal_worm"]         = 5,
        ["$animal_worm_big"]     = 6,
    }
    local threshold = worm_speeds[name]
    if threshold ~= nil then
        rotate = true
        local comp = EntityGetFirstComponent(entity, "WormComponent")
        if comp ~= nil then
            local xs, ys = ComponentGetValueVector2(comp, "mTargetVec")
            local ym = ComponentGetValue2(comp, "mGravVelocity")
            if xs ~= nil and ys ~= nil and ym ~= nil then
                local velocity = math.abs(xs) + math.abs(ys) + math.abs(ym)
                if velocity > threshold then
                    local special = {
                        "WOOOOOOOOO!",
                        "YEAAAAHHHH!",
                        "RAAAAAAAHH!",
                        "LET'S GOOO!"
                    }
                    text = special[Random(1, #special)]
                    size_x = size_x + threshold / 20
                    size_y = size_y + threshold / 20
                end
            end
        end
    end

    -- Appended stuff
    ModdedStuff()

    if ModIsEnabled("translation_uwu") then
        dofile_once("mods/translation_uwu/init.lua")
        ---@diagnostic disable-next-line: undefined-global
        text = owoify(text)
    end

    ---- All dialogue handling should go above this point, don't tinker with stuff down here ----
    local gui = GuiCreate()
    GuiStartFrame(gui)
    local width = GuiGetTextDimensions( gui, text, 1 ) / 2 -- special scale after offset_x
    GuiDestroy(gui)

    EntityAddTag(entity, "graham_speaking")
    EntityAddComponent2(entity, "SpriteComponent", {
        _tags = "enabled_in_world, graham_speech_text",
        image_file = "data/fonts/font_pixel_white.xml",
        emissive = ModSettingGet("grahamsdialogue.visibility"),
        is_text_sprite = true,
        offset_x = width,
        offset_y = offset_y,
        alpha = alpha,
        update_transform = true,
        update_transform_rotation = rotate,
        text = text,
        has_special_scale = true,
        special_scale_x = size_x,
        special_scale_y = size_y,
        z_index = -9000,
        never_ragdollify_on_death = true
    })

    local luacomp = EntityGetFirstComponentIncludingDisabled(entity, "LuaComponent", "graham_speech_quiet")
    if luacomp then EntityRemoveComponent(entity, luacomp) end

    EntityAddComponent2(entity, "LuaComponent", {
        _tags= "graham_speech_quiet",
        execute_every_n_frame=ModSettingGet("grahamsdialogue.length"),
        script_source_file="mods/grahamsdialogue/files/quiet.lua"
    })
end