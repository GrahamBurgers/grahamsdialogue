function OnPlayerSpawned(player)
    if not EntityHasTag(player, "graham_dialogue_added") then
        EntityAddTag(player, "graham_dialogue_added")
        EntityAddComponent2(player, "LuaComponent", {
            execute_every_n_frame=-1,
            script_damage_received="mods/grahamsdialogue/player_damaged.lua",
            remove_after_executed=false,
        })
    end
end

function OnWorldPreUpdate()
    local enemies = EntityGetWithTag("enemy")
    for i = 1, #enemies do
        if not EntityHasTag(enemies[i], "graham_dialogue_added") then
            EntityAddTag(enemies[i], "graham_dialogue_added")
            EntityAddComponent2(enemies[i], "LuaComponent", {
                execute_every_n_frame=-1,
                script_damage_received="mods/grahamsdialogue/damaged.lua"
            })
            EntityAddComponent2(enemies[i], "LuaComponent", {
                execute_every_n_frame=30,
                script_source_file="mods/grahamsdialogue/idle.lua"
            })
        end
    end
    local playerpoly = EntityGetWithTag("player_polymorphed")
    for i = 1, #playerpoly do
        if not EntityHasTag(playerpoly[i], "graham_dialogue_added") then
            EntityAddTag(playerpoly[i], "graham_dialogue_added")
            EntityAddComponent2(playerpoly[i], "LuaComponent", {
                execute_every_n_frame=-1,
                script_damage_received="mods/grahamsdialogue/player_damaged.lua",
                remove_after_executed=false,
            })
        end
    end
end