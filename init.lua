local nxml = dofile_once("mods/grahamsdialogue/files/lib/nxml.lua")
dofile_once("mods/grahamsdialogue/files/lib/injection.lua")
GetContent = GetContent or ModTextFileGetContent

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
	{ "data/entities/animals/boss_spirit/wisp.xml",                   "boss_spirit_wisp"}
}
ModDoesFileExist = ModDoesFileExist or function(path) return ModTextFileGetContent(path) ~= nil end

for i = 1, #filepaths do
	local path = filepaths[i][1]
	if ModDoesFileExist(path) then -- may cause errors if not on beta branch
		local content = ModTextFileGetContent(path)
		if content ~= nil then
			local tree = nxml.parse(content)
			table.insert(tree.children, nxml.parse(
				'<LuaComponent script_source_file="mods/grahamsdialogue/files/custom/custom_speak.lua" execute_every_n_frame="1" script_polymorphing_to="' ..
				filepaths[i][2] ..
				'" script_collision_trigger_timer_finished="' .. (filepaths[i][3] or "") .. '"></LuaComponent>'))
			tree.attr.tags = "graham_enemydialogue," .. (tree.attr.tags or "")
			ModTextFileSetContent(path, tostring(tree))
		end
	end
end

inject(args.StringString, modes.APPEND, "data/scripts/buildings/racing_cart_checkpoint.lua", "best_time = lap_time", [[

dofile_once("mods/grahamsdialogue/files/common.lua")
for i = 1, #Custom_speak_lines do
    if Custom_speak_lines[i][1] == "karl_lap" then
        Speak(entity_id, GetLine(Custom_speak_lines,i,pools.KARL), pools.CUSTOM, true, true, "karl")
        break
    end
end
]])

-- he can't die more than once so rng is not needed
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

-- all of these are 1 / run or don't speak

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
		[[<LuaComponent execute_every_n_frame="30" script_source_file="mods/grahamsdialogue/files/custom/kolmi_generic.lua"></LuaComponent>]]
	))
ModTextFileSetContent("data/entities/animals/boss_centipede/boss_centipede.xml", tostring(tree))

if ModIsEnabled("grahamsperks") then
	tree = nxml.parse(ModTextFileGetContent("mods/grahamsperks/files/spells/panic_bomb.xml"))
	table.insert(tree.children,
		nxml.parse(
			[[<LuaComponent remove_after_executed="1" script_source_file="mods/grahamsdialogue/files/custom/panic_bomb.lua"></LuaComponent>]]
		))
	ModTextFileSetContent("mods/grahamsperks/files/spells/panic_bomb.xml", tostring(tree))
end

inject(args.StringString, modes.APPEND, "data/entities/animals/boss_pit/boss_pit_logic.lua",
	"-- we're stuck, lets hunt for that connoisseur of cheese",
	[[

	dofile_once("mods/grahamsdialogue/files/common.lua")
	for i = 1, #Custom_speak_lines do
		if Custom_speak_lines[i][1] == "squidward_cheese" then
			local type = Random(2, #Custom_speak_lines[i])
			Speak(entity_id, Custom_speak_lines[i][type], pools.CUSTOM, true, true)
			break
		end
	end
]])

inject(args.StringString, modes.APPEND, "data/scripts/animals/longleg_pet.lua",
	"local rnd = Random( 1, 20 )",
	[[

	dofile_once("mods/grahamsdialogue/files/common.lua")
	for i = 1, #Custom_speak_lines do
		if Custom_speak_lines[i][1] == "hamis_pet" then
			local type = Random(2, #Custom_speak_lines[i])
			Speak(entity_interacted, Custom_speak_lines[i][type], pools.CUSTOM, true, true)
			break
		end
	end
]])

function OnPlayerSpawned(player)
	if not EntityHasTag(player, "graham_dialogue_added") then
		EntityAddTag(player, "graham_dialogue_added")
		EntityAddComponent2(player, "LuaComponent", {
			execute_every_n_frame = -1,
			script_damage_received = "mods/grahamsdialogue/files/player_damaged.lua",
			remove_after_executed = false,
		})
		EntityAddComponent2(player, "LuaComponent", {
			execute_every_n_frame = -1,
			script_death = "mods/grahamsdialogue/files/player_death.lua",
			remove_after_executed = true,
		})
	end
end

---@param file string
---@return string
local function traverse_base_tree(file)
	-- print("seen "..file)
	if file:sub(1, 4) ~= "data" and file:sub(1, 3) ~= "mods" then return "" end -- the stupid api says bones exist but they can't be read.
	if not ModDoesFileExist(file) then return "" end
	-- print("going for file")
	local tree = nxml.parse(GetContent(file))
	local name = tree.attr.name
	if name ~= nil then return name end
	for k, v in ipairs(tree.children) do
		if v.name == "Base" then
			return traverse_base_tree(v.attr.file)
		end
	end
	return ""
end

local function split(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t = {}
	for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
		table.insert(t, str)
	end
	return t
end

local function consume_buffer()
	local buffer = GlobalsGetValue("grahamsdialogue.buffer", "")
	-- we have to consume the buffer fully to stop noita from detonating
	local parts = split(buffer, ",") -- literal miracle this shit works, i can't believe it
	for k, v in ipairs(parts) do
		-- print(v)
		if GlobalsGetValue("grahamsdialogue.readback." .. v, "killingpetri") ~= "killingpetri" then goto continue end
		-- print(v)
		if not ModDoesFileExist(v) then goto continue end
		-- print(v)
		if v == "??SAV/player.xml" then goto continue end -- execute
		-- print(v)
		local name = traverse_base_tree(v)
		GlobalsSetValue("grahamsdialogue.readback." .. v, name)
		::continue::
	end
	GlobalsSetValue("grahamsdialogue.buffer", "")
end

-- how to kill petri in 3 easy steps??
function OnWorldPreUpdate()
	if GameGetFrameNum() > 5 and GameGetFrameNum() % 60 == 0 then -- hax
		dofile_once("mods/grahamsdialogue/files/common.lua")
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
		consume_buffer()
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
