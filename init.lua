function OnPlayerSpawned(player)
    if not EntityHasTag(player, "graham_dialogue_added") then
        EntityAddTag(player, "graham_dialogue_added")
        EntityAddComponent2(player, "LuaComponent", {
            execute_every_n_frame=-1,
            script_damage_received="mods/grahamsdialogue/files/player_damaged.lua",
            remove_after_executed=false,
        })
    end
end

function OnWorldPreUpdate()
    local enemies = EntityGetWithTag("hittable")
    for i = 1, #enemies do
        if not EntityHasTag(enemies[i], "graham_dialogue_added") then
            EntityAddTag(enemies[i], "graham_dialogue_added")
            EntityAddComponent2(enemies[i], "LuaComponent", {
                execute_every_n_frame=-1,
                script_damage_received="mods/grahamsdialogue/files/damaged.lua"
            })
            EntityAddComponent2(enemies[i], "LuaComponent", {
                execute_every_n_frame=30,
                script_source_file="mods/grahamsdialogue/files/idle.lua"
            })
        end
    end
    local special = EntityGetWithTag("graham_enemydialogue")
    for i = 1, #special do
        if not EntityHasTag(special[i], "graham_dialogue_added") then
            EntityAddTag(special[i], "graham_dialogue_added")
            EntityAddComponent2(special[i], "LuaComponent", {
                execute_every_n_frame=-1,
                script_damage_received="mods/grahamsdialogue/files/damaged.lua"
            })
            EntityAddComponent2(special[i], "LuaComponent", {
                execute_every_n_frame=30,
                script_source_file="mods/grahamsdialogue/files/idle.lua"
            })
        end
    end
end

function OnModPreInit()
    -- not jank
    local content = ModTextFileGetContent("mods/translation_uwu/init.lua")
    content = content:gsub("local function", "function")
    ModTextFileSetContent("mods/translation_uwu/init.lua", content)
end