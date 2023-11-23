local nxml = dofile_once("mods/grahamsdialogue/files/lib/nxml.lua")
dofile_once("mods/grahamsdialogue/files/lib/injection.lua")

local filepaths = {
	-- note: this may or may not work if the filepath has a child entity
	{ "data/entities/misc/perks/angry_ghost.xml",                     "angry_ghost" },
	{ "data/entities/misc/perks/hungry_ghost.xml",                    "hungry_ghost" },
	{ "data/entities/misc/perks/death_ghost.xml",                     "mournful_spirit" },
	{ "mods/grahamsperks/files/entities/tipsy_ghost/tipsy_ghost.xml", "tipsy_ghost" },
	{ "data/entities/misc/perks/tiny_ghost_extra.xml",                "tiny_ghost" },
	{ "data/entities/misc/perks/ghostly_ghost.xml",                   "ghostly_ghost" },
	{ "data/entities/buildings/racing_cart.xml",                      "karl" },
}

for i = 1, #filepaths do
	if ModDoesFileExist == nil or ModDoesFileExist(filepaths[i][1]) then -- may cause errors if not on beta branch
		local path = filepaths[i][1]
		local content = ModTextFileGetContent(path)
		if content ~= nil then
			local tree = nxml.parse(content)
			table.insert(tree.children, nxml.parse(
				'<LuaComponent script_source_file="mods/grahamsdialogue/files/custom_speak.lua" execute_every_n_frame="30" script_polymorphing_to="' ..
				filepaths[i][2] .. '"></LuaComponent>'))
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
		local enemies = EntityGetWithTag("mortal")
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
		local orbs = EntityGetWithTag("graham_orbdialogue")
		for k, orb in ipairs(orbs) do
			-- doesn't exist lol
		end
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
