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
    ["$animal_statue_physics"]           = "$animal_statue",
})

function NameGet(entity)
    local name = EntityGetName(entity) or ""
    name = DUPES[name] or name
    return name
end

function ModdedStuff()
    -- APPEND HERE! This function will be called right before dialogue is shown.
    -- See README_MODDERS.lua for more info
end

Special_offsets_y = ({ -- for when an enemy is taller or shorter than expected
    ["$animal_boss_alchemist"]        = 60,
    ["$animal_parallel_alchemist"]    = 60,
    ["$animal_boss_pit"]              = 13,
    ["$animal_parallel_tentacles"]    = 13,
    ["$animal_necromancer_shop"]      = 8,
    ["$animal_necromancer_super"]     = 10,
    ["$animal_firemage"]              = 6,
    ["$animal_firemage_weak"]         = 6,
    ["$animal_thundermage"]           = 6,
    ["$animal_tentacler"]             = 8,
    ["$animal_giant"]                 = 6,
    ["$animal_pebble"]                = -6,
    ["$animal_rat"]                   = -4,
    ["$animal_drone"]                 = -12,
    ["$animal_scavenger_leader"]      = 8,
    ["$animal_scavenger_clusterbomb"] = 8,
    ["$animal_scavenger_mine"]        = 8,
    ["$animal_necromancer"]           = 10,
    ["$animal_worm_tiny"]             = -10,
    ["$animal_worm"]                  = -7,
    ["$animal_worm_big"]              = -4,
    ["$animal_phantom_a"]             = 4,
    ["$animal_phantom_b"]             = 4,
    ["$animal_flamer"]                = 4,
    ["$animal_icer"]                  = 4,
    ["$animal_lukki_tiny"]            = -8,
    ["$graham_lukkimount_name"]       = -38,
    ["$animal_boss_dragon"]           = 4,
    ["$animal_failed_alchemist"]      = 18,
    ["$animal_failed_alchemist_b"]    = 10,
    ["$animal_enlightened_alchemist"] = 24,
})

function EnemyHasDialogue(pool, name)
    if name == nil then return false end
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

function Speak(entity, text, pool, check_name)
    pool = pool or ""
    local textComponent = EntityGetFirstComponentIncludingDisabled(entity, "SpriteComponent", "graham_speech_text")
    if textComponent then return end

    local rotate = false
    local old_text = text
    local x, y = EntityGetTransform(entity)
    SetRandomSeed(entity + x + 2352, GameGetFrameNum() - y + 24806)
    local size_x = 0.65
    local size_y = 0.65

    local alpha = (100 - ModSettingGet("grahamsdialogue.transparency")) / 100
    local name = NameGet(entity)
    local offset_y = 28 + ((Special_offsets_y[name] or 0) * 1.2)
    local font = "data/fonts/font_pixel_white.xml"

    check_name = check_name or true
    if check_name then --!!!--

    if not (EntityHasTag(entity, "graham_enemydialogue") or EnemyHasDialogue("ANY", name)) then return end
    -- player should never speak
    if EntityHasTag(entity, "player_unit") or EntityHasTag(entity, "player_polymorphed") or EntityHasTag(entity, "polymorphed_player") then return end

    local genome = EntityGetFirstComponent(entity, "GenomeDataComponent")
    local faction
    if genome ~= nil then
        faction = HerdIdToString(ComponentGetValue2(genome, "herd_id"))
    end

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

    local special_dialogue = {
        ["$animal_necromancer_shop"] = function()
            if pool == "IDLE" and GlobalsGetValue( "TEMPLE_PEACE_WITH_GODS" ) == "1" then
                local special = {
                    "I suppose I can let it slide. But just this once!",
                    "Don't think that this means that you're off the hook...",
                    "Fine... harumph.",
                }
                text = special[Random(1, #special)]
            end
        end,
        ["$animal_necromancer_super"] = function()
            if pool == "IDLE" and GlobalsGetValue( "TEMPLE_PEACE_WITH_GODS" ) == "1" then
                local special = {
                    "A sinful being you are... But perhaps a little bit endearing.",
                    "Don't be mistaken. It is by command of the gods that I spare your life today.",
                    "I'm sure you have your reasons. But so do I.",
                }
                text = special[Random(1, #special)]
            end
        end,
        ["$animal_firemage"] = function()
            if pool == "IDLE" then
                local items = EntityGetInRadiusWithTag(x, y, 180, "item_pickup")
                local found = false
                for i = 1, #items do
                    local comps = EntityGetComponent(items[i], "GameEffectComponent", "enabled_in_hand") or {}
                    for j = 1, #comps do
                        if ComponentGetValue2(comps[j], "effect") == "FRIEND_FIREMAGE" then
                            local special = {
                                "Nice stone you got there. Is it for sale?",
                                "That flame... it reminds me of myself when I was younger.",
                                "Come a bit closer. I'd like to get a closer look at that item.",
                            }
                            text = special[Random(1, #special)]
                            found = true
                            break
                        end
                        if found then break end
                    end
                end
            end
        end,
        ["$animal_thundermage"] = function()
            if pool == "IDLE" then
                local items = EntityGetInRadiusWithTag(x, y, 180, "item_pickup")
                local found = false
                for i = 1, #items do
                    local comps = EntityGetComponent(items[i], "GameEffectComponent", "enabled_in_hand") or {}
                    for j = 1, #comps do
                        if ComponentGetValue2(comps[j], "effect") == "FRIEND_THUNDERMAGE" then
                            local special = {
                                "What a beautiful stone. Take good care of it.",
                                "It looks like you appreciate the art of electricity almost as much as I do.",
                                "I would normally blast you to pieces, but...",
                            }
                            text = special[Random(1, #special)]
                            found = true
                            break
                        end
                        if found then break end
                    end
                end
            end
        end,
        ["$animal_thunderskull"] = function()
            if (pool == "DAMAGEDEALT" or pool == "DAMAGETAKEN") and GameHasFlagRun("PERK_PICKED_ELECTRICITY") then
                local special = {
                    "Yo! A fellow electricity user?!",
                    "I never expected to see someone as rad as me down here!",
                    "I'm a fan of the volts you're outputting, friend.",
                }
                text = special[Random(1, #special)]
            end
        end,
        ["$animal_iceskull"] = function()
            if (pool == "DAMAGEDEALT" or pool == "DAMAGETAKEN") and GameHasFlagRun("PERK_PICKED_GRAHAM_REVENGE_FREEZE") then
                local special = {
                    "Hey, you also have retaliation projectiles? N-ice.",
                    "Your perks are cool! And I mean that literally.",
                    "We should make some ice sculptures together, some time.",
                }
                text = special[Random(1, #special)]
            end
        end,
        ["$animal_icemage"] = function()
            if (pool == "DAMAGEDEALT" or pool == "DAMAGETAKEN") and GameHasFlagRun("PERK_PICKED_FREEZE_FIELD") then
                local special = {
                    "Ice skate with me, friend!",
                    "Are you feeling that winter spirit?",
                    "I get stuck in ice so often. What are your secrets?",
                }
                text = special[Random(1, #special)]
            end
        end,
        ["$animal_giant"] = function()
            local enemies = EntityGetInRadiusWithTag(x, y, 140, "glue_NOT")
            for i = 1, #enemies do
                if EntityGetName(enemies[i]) == "$animal_pebble" then
                    Speak(enemies[i], text, pool)
                end
            end
        end,
        ["$animal_graham_fuzz"] = function()
            if faction == "player" and pool == "IDLE" then
                local special = {
                    "Just here to say hi. I'll be on my way soon.",
                    "I don't see what's so bad about you.",
                    "Do not pet. I will zap you.",
                    "Have I told you how fun it is to spin like this?",
                    "You're really one-of-a-kind, aren't you?",
                    "Take a break with me. You need some time to breathe, too.",
                    "I might shoot at you once I leave. Sorry about that.",
                    "This is so cozy, I might just fall asleep.",
                }
                text = special[Random(1, #special)]
            end
        end,
        ["$animal_pebble"] = function()
            size_x = size_x - 0.8
            size_y = size_y - 0.8
        end,
        ["$animal_miniblob"] = function()
            size_x = size_x - 0.10
            size_y = size_y - 0.10
        end,
        ["$animal_lukki_tiny"] = function()
            size_x = size_x - 0.05
            size_y = size_y - 0.05
        end,
        ["$animal_miner_santa"] = function()
            if StatsBiomeGetValue("enemies_killed") < 1 and pool == "DAMAGEDEALT" then
                local special = {
                    "Pacifism? You might be deserving of the Nice List after all.",
                    "You've been a good person so far. Christmas awaits!",
                    "Finally... someone that can appreciate the holiday spirit.",
                }
                text = special[Random(1, #special)]
            end
        end,
        ["$graham_lukkimount_name"] = function()
            local who = ComponentGetValue2(EntityGetFirstComponent(entity, "VariableStorageComponent") or 0, "value_int")
            if who == 0 or who == nil then text = "" end
            if BiomeMapGetName(x, y) == "$biome_rainforest" and Random(1, 3) == 1 and pool == "IDLE" then
                local special = {
                    "Ah, it's nice to be home in the jungle.",
                    "It really has been a while. I don't recognize anyone here...",
                    "Can we stay here a bit longer? I've missed it dearly...",
                    "The air is so fresh here. It's a bit strange.",
                    "Compared to everything else underneath the mountain, this place is...",
                    "I'm enjoying just exploring the world with you. Though it's nice to be home.",
                }
                text = special[Random(1, #special)]
            end
        end,
    }

    if faction == "robot" then
        size_x = size_x + 0.06
    end
    if faction == "fungus" then
        size_y = size_y + 0.06
    end
    if faction == "player" then
        size_x = size_x + 0.025
        size_y = size_y + 0.025
    end
    if faction == "ghost" then
        EntityAddComponent2(entity, "LuaComponent", {
            _tags="graham_speech_ghost",
            execute_every_n_frame=1,
            script_source_file="mods/grahamsdialogue/files/ghost.lua"
        })
    end

    local worm_speeds = {
        ["$animal_worm_tiny"]    = 6,
        ["$animal_worm"]         = 7,
        ["$animal_worm_big"]     = 8,
        ["$animal_boss_dragon"]  = 20,
        ["$animal_worm_skull"]   = 10,
    }
    -- Appended stuff
    ModdedStuff()

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
                    }
                    text = special[Random(1, #special)]
                    size_x = size_x + threshold / 20
                    size_y = size_y + threshold / 20
                end
            end
        end
    end

    -- This is where all the stuff actually happens!
    if special_dialogue[name] ~= nil then
        special_dialogue[name]()
    end

    end --!!!--
    
    if text == "" or text == nil then return end -- utility; if text is nothing then don't speak at all

    if ModIsEnabled("translation_uwu") then -- Haunted
        dofile_once("mods/translation_uwu/init.lua")
        ---@diagnostic disable-next-line: undefined-global
        text = owoify(text)
    end
    if ModIsEnabled("salakieli") then font = "mods/grahamsdialogue/files/font_runes_white.xml" end
    if GameGetGameEffectCount(entity, "CONFUSION") > 0 then text = string.reverse(text) end -- thanks sycokinetic for telling me about string.reverse lol

    ---- All dialogue handling should go above this point, don't tinker with stuff down here ----
    local size = ModSettingGet("grahamsdialogue.scale")
    size_x = size_x * size
    size_y = size_y * size

    local gui = GuiCreate()
    GuiStartFrame(gui)
    local width = GuiGetTextDimensions( gui, text, 1 ) / 2 -- special scale after offset_x
    GuiDestroy(gui)

    EntityAddTag(entity, "graham_speaking")
    EntityAddComponent2(entity, "SpriteComponent", {
        _tags = "enabled_in_world, graham_speech_text",
        image_file = font,
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
        script_source_file="mods/grahamsdialogue/files/quiet.lua",
        remove_after_executed=true,
    })
end