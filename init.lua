local nxml = dofile_once("mods/grahamsdialogue/files/lib/nxml.lua")
dofile_once("mods/grahamsdialogue/files/lib/injection.lua")

local filepaths = {
	-- note: this may or may not work if the filepath has a child entity (use true to ignore children)
	{ "data/entities/misc/perks/angry_ghost.xml",                     "angry_ghost" },
	{ "data/entities/misc/perks/hungry_ghost.xml",                    "hungry_ghost" },
	{ "data/entities/misc/perks/death_ghost.xml",                     "mournful_spirit" },
	{ "mods/grahamsperks/files/entities/tipsy_ghost/tipsy_ghost.xml", "tipsy_ghost" },
	{ "data/entities/misc/perks/tiny_ghost_extra.xml",                "tiny_ghost" },
	{ "data/entities/misc/perks/ghostly_ghost.xml",                   "ghostly_ghost" },
	{ "data/entities/buildings/racing_cart.xml",                      "karl" },
	{ "mods/grahamsperks/files/entities/mini_tanks/tank.xml",         "minitank" },
	{ "mods/grahamsperks/files/entities/mini_tanks/tank_rocket.xml",  "minitank" },
	{ "mods/grahamsperks/files/entities/mini_tanks/tank_super.xml",   "minitank" },
	{ "mods/grahamsperks/files/entities/mini_tanks/toasterbot.xml",   "minitank" },
	{ "mods/lap2/files/entities/chaser.xml",                          "Calamariface",   "true" },
	{ "data/entities/misc/perks/lukki_minion.xml",                    "lukki_minion",   "true" },
	{ "data/entities/projectiles/deck/swarm_fly.xml",                 "swarm_fly" },
	{ "data/entities/projectiles/deck/swarm_firebug.xml",             "swarm_firebug" },
	{ "data/entities/projectiles/deck/swarm_wasp.xml",                "swarm_wasp" },
	{ "data/entities/projectiles/deck/friend_fly.xml",                "swarm_fly" },
}

for i = 1, #filepaths do
	if ModDoesFileExist == nil or ModDoesFileExist(filepaths[i][1]) then -- may cause errors if not on beta branch
		local path = filepaths[i][1]
		local content = ModTextFileGetContent(path)
		if content ~= nil then
			local tree = nxml.parse(content)
			table.insert(tree.children, nxml.parse(
				'<LuaComponent script_source_file="mods/grahamsdialogue/files/custom/custom_speak.lua" execute_every_n_frame="30" script_polymorphing_to="' ..
				filepaths[i][2] ..
				'" script_collision_trigger_timer_finished="' .. (filepaths[i][3] or "") .. '"></LuaComponent>'))
			tree.attr.tags = "graham_enemydialogue," .. (tree.attr.tags or "")
			ModTextFileSetContent(path, tostring(tree))
		end
	end
end

-- TODO: use GetLine() for these
inject(args.StringString, modes.APPEND, "data/scripts/buildings/racing_cart_checkpoint.lua", "best_time = lap_time", [[

dofile_once("mods/grahamsdialogue/files/common.lua")
for i = 1, #Custom_speak_lines do
    if Custom_speak_lines[i][1] == "karl_lap" then
        local type = Random(2, #Custom_speak_lines[i])
        Speak(entity_id, Custom_speak_lines[i][type], pools.CUSTOM, true, true, "karl")
        break
    end
end
]])

inject(args.StringString, modes.APPEND, "data/entities/animals/boss_limbs/boss_limbs_update.lua", "-- run death sequence",
	[[

dofile_once("mods/grahamsdialogue/files/common.lua")
for i = 1, #Custom_speak_lines do
	if Custom_speak_lines[i][1] == "boss_limbs_death" then
		SetRandomSeed(GetUpdatedEntityID(), GetUpdatedEntityID())
		local type = Random(2, #Custom_speak_lines[i])
		Speak(GetUpdatedEntityID(), Custom_speak_lines[i][type], pools.CUSTOM, true, true)
		break
	end
end
]])

inject(args.StringString, modes.APPEND, "data/entities/animals/boss_centipede/boss_centipede_before_fight.lua",
	"player_nearby = true",
	[[

dofile("mods/grahamsdialogue/files/custom/kolmi.lua")
]])

inject(args.StringString, modes.APPEND, "data/entities/animals/boss_centipede/sampo_pickup.lua",
	"PhysicsSetStatic( entity_id, false )",
	[[

	dofile_once("mods/grahamsdialogue/files/common.lua")
	for i = 1, #Custom_speak_lines do
		if Custom_speak_lines[i][1] == "kolmi_begin" then
			local type = Random(2, #Custom_speak_lines[i])
			Speak(entity_id, Custom_speak_lines[i][type], pools.CUSTOM, true, true)
			break
		end
	end
]])

inject(args.StringString, modes.APPEND, "data/entities/animals/boss_centipede/boss_centipede_update.lua",
	"death_sound_started = true",
	[[

	dofile_once("mods/grahamsdialogue/files/common.lua")
	for i = 1, #Custom_speak_lines do
		if Custom_speak_lines[i][1] == "kolmi_death" then
			local type = Random(2, #Custom_speak_lines[i])
			Speak(entity_id, Custom_speak_lines[i][type], pools.CUSTOM, true, true)
			break
		end
	end
]])

inject(args.StringString, modes.APPEND, "data/entities/animals/boss_centipede/testcheck.lua", "local handled = {}",
	[[

	dofile_once("mods/grahamsdialogue/files/common.lua")
	for i = 1, #Custom_speak_lines do
		if Custom_speak_lines[i][1] == "kolmi_gourd" then
			local type = Random(2, #Custom_speak_lines[i])
			Speak(entity_id, Custom_speak_lines[i][type], pools.CUSTOM, true, true)
			break
		end
	end
]])

inject(args.StringString, modes.PREPEND, "data/entities/animals/boss_centipede/boss_centipede_update.lua", "\tphase()",
	[[
	local phases = {
		[phase_chase_slow] = "slow_chase",
		[phase_chase] = "chase",
		[phase_chase_direct] = "chase_direct",
		[phase_circleshot] = "circleshot",
		[phase_spawn_minion] = "spawn_minion",
		[phase_firepillar] = "firepillar",
		[phase_explosion] = "explosion",
		[phase_homingshot] = "homingshot",
		[phase_polymorph] = "polymorph",
		[phase_melee] = "melee",
		[phase_clean_materials] = "clean_materials",
		[phase_aggro] = "aggro",
	}
	-- print(tostring(phase))
	-- for k,v in pairs(phases) do print(tostring(k)) end
	local phase_str = phases[phase]
	-- print(tostring(phase_str))
	GlobalsSetValue("grahamsdialogue_kolmi_phase", phase_str)
]])

local tree = nxml.parse(ModTextFileGetContent("data/entities/animals/boss_centipede/boss_centipede.xml"))
table.insert(tree.children,
	nxml.parse(
		[[<LuaComponent execute_every_n_frame="5" script_source_file="mods/grahamsdialogue/files/custom/kolmi_generic.lua"></LuaComponent>]]
	))
ModTextFileSetContent("data/entities/animals/boss_centipede/boss_centipede.xml", tostring(tree))

function OnPlayerSpawned(player)
	if not EntityHasTag(player, "graham_dialogue_added") then
		EntityAddTag(player, "graham_dialogue_added")
		EntityAddComponent2(player, "LuaComponent", {
			execute_every_n_frame = -1,
			script_damage_received = "mods/grahamsdialogue/files/player_damaged.lua",
			remove_after_executed = false,
		})
	end
end

function OnWorldPreUpdate()
	if GameGetFrameNum() > 5 then -- hax
		-- TODO: this code path might be moderately hot, consider doing `and (GameGetFrameNum % alpha == 0)`
		dofile("mods/grahamsdialogue/files/common.lua")
		local enemies = EntityGetWithTag("hittable")
		for _k, enemy in ipairs(enemies) do
			local name = NameGet(enemy)
			if not EntityHasTag(enemy, "graham_dialogue_added") and EnemyHasDialogue(pools.ANY, name) then
				EntityAddTag(enemy, "graham_dialogue_added")
				EntityAddComponent2(enemy, "LuaComponent", {
					execute_every_n_frame = -1,
					script_damage_received = "mods/grahamsdialogue/files/damaged.lua"
				})
				EntityAddComponent2(enemy, "LuaComponent", {
					execute_every_n_frame = 30,
					script_source_file = "mods/grahamsdialogue/files/idle.lua"
				})
			end
		end
		local specials = EntityGetWithTag("graham_enemydialogue")
		for _k, special in ipairs(specials) do
			if not EntityHasTag(special, "graham_dialogue_added") then
				EntityAddTag(special, "graham_dialogue_added")
				EntityAddComponent2(special, "LuaComponent", {
					execute_every_n_frame = -1,
					script_damage_received = "mods/grahamsdialogue/files/damaged.lua"
				})
				EntityAddComponent2(special, "LuaComponent", {
					execute_every_n_frame = 30,
					script_source_file = "mods/grahamsdialogue/files/idle.lua"
				})
			end
		end
		-- local orbs = EntityGetWithTag("graham_orbdialogue")
		-- for k, orb in ipairs(orbs) do
		-- 	-- doesn't exist lol
		-- end
	end
end

function OnModPreInit()
	if ModIsEnabled("translation_uwu") then -- foul code
		-- hax
		local content = ModTextFileGetContent("mods/translation_uwu/init.lua")
		content = content:gsub("local function", "function")
		ModTextFileSetContent("mods/translation_uwu/init.lua", content)
	end
end
