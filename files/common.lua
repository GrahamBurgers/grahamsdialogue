dofile("mods/grahamsdialogue/files/dialogue.lua")
dofile("mods/grahamsdialogue/files/types.lua")

DUPES = ({ -- for when multiple enemy translation entries are identical
	["$animal_zombie_weak"]           = "$animal_zombie",
	["$animal_shotgunner_weak"]       = "$animal_shotgunner",
	["$animal_miner_weak"]            = "$animal_miner",
	["$animal_slimeshooter_weak"]     = "$animal_slimeshooter",
	["$animal_giantshooter_weak"]     = "$animal_giantshooter",
	["$animal_acidshooter_weak"]      = "$animal_acidshooter",
	["$animal_slimeshooter_nontoxic"] = "$animal_slimeshooter",
	["$animal_drone_physics"]         = "$animal_drone",
	["$animal_turret_right"]          = "$animal_turret",
	["$animal_turret_left"]           = "$animal_turret",
	["$animal_statue_physics"]        = "$animal_statue",
	["angry_ghost"]                   = "generic_ghost",
	["hungry_ghost"]                  = "generic_ghost",
	["mournful_spirit"]               = "generic_ghost",
	["tipsy_ghost"]                   = "generic_ghost",
	["tiny_ghost"]                    = "generic_ghost",
	["ghostly_ghost"]                 = "generic_ghost",
})

---@param entity integer
---@return string
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
	["$animal_drone"]                 = -10,
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
	["$animal_fungus_big"]            = 8,
	["$animal_fungus_giga"]           = 24,
	["$animal_skullfly"]              = 8,
	["$animal_spearbot"]              = 12,
	["$animal_roboguard"]             = 4,
	["$animal_piranha"]               = 4,
	["generic_ghost"]                 = -8,
	["$animal_friend"]                = 10,
	["$animal_ultimate_killer"]       = -8,
	["$animal_longleg"]               = -4,
	["$animal_zombie"]                = -4,
	["$animal_thundermage_big"]       = 20,
	["$animal_spitmonster"]           = 8,
	["karl"]                          = -4,
	["$animal_necrobot"]              = 8,
	["$animal_necrobot_super"]        = 8,
	["$animal_fish_giga"]             = -12,
	["$animal_boss_limbs"]            = 12,
})

Special_sizes = ({ -- for when an enemy needs larger or smaller text
	["$animal_pebble"]         = -0.8,
	["$animal_miniblob"]       = -0.10,
	["$animal_lukki_tiny"]     = -0.05,
	["$animal_lukki_dark"]     = 0.20,
	["$animal_worm_end"]       = 0.15,
	["$animal_boss_dragon"]    = 0.10,
	["$animal_fish_giga"]      = 0.10,
	["$animal_gate_monster_a"] = 0.10,
	["$animal_gate_monster_b"] = 0.10,
	["$animal_gate_monster_c"] = 0.10,
	["$animal_gate_monster_d"] = 0.10,
	["generic_ghost"]          = -0.08,
	["karl"]                   = -0.04,
	["$animal_boss_limbs"]     = 0.10,
})

---Returns the index of the dialogue in the dialogue table or false if it doesn't exist
---@param pool pool
---@param name string
---@return integer?
function EnemyHasDialogue(pool, name)
	if name == nil then return nil end
	local what = {}
	if pool == pools.IDLE then what = DIALOGUE_IDLE end
	if pool == pools.DAMAGETAKEN then what = DIALOGUE_DAMAGETAKEN end
	if pool == pools.DAMAGEDEALT then what = DIALOGUE_DAMAGEDEALT end
	if what ~= {} then
		for i = 1, #what do
			if what[i][1] == name then return i end
		end
	end
	if pool == pools.ANY then
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
	return nil
end

---Registers enemy dialogue into the dialogue table provided
---@param pool pool
---@param name string
---@param dialogue string[]
function AddEnemyDialogue(pool, name, dialogue)
	local has = EnemyHasDialogue(pool, name)
	local what = {}
	if pool == pools.IDLE then what = DIALOGUE_IDLE end
	if pool == pools.DAMAGETAKEN then what = DIALOGUE_DAMAGETAKEN end
	if pool == pools.DAMAGEDEALT then what = DIALOGUE_DAMAGEDEALT end
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
	if pool == pools.IDLE then DIALOGUE_IDLE = what end
	if pool == pools.DAMAGETAKEN then DIALOGUE_DAMAGETAKEN = what end
	if pool == pools.DAMAGEDEALT then DIALOGUE_DAMAGEDEALT = what end
end

---@param pool pool
---@param name string
function EmptyEnemyDialogue(pool, name)
	local has = EnemyHasDialogue(pool, name)
	local what = {}
	if pool == pools.IDLE then what = DIALOGUE_IDLE end
	if pool == pools.DAMAGETAKEN then what = DIALOGUE_DAMAGETAKEN end
	if pool == pools.DAMAGEDEALT then what = DIALOGUE_DAMAGEDEALT end

	if has then
		table.remove(what, has)
	end

	if pool == pools.IDLE then DIALOGUE_IDLE = what end
	if pool == pools.DAMAGETAKEN then DIALOGUE_DAMAGETAKEN = what end
	if pool == pools.DAMAGEDEALT then DIALOGUE_DAMAGEDEALT = what end
end

---@param entity integer
function RemoveCurrentDialogue(entity)
	if not EntityGetIsAlive(entity) then return end
	EntityRemoveTag(entity, "graham_speaking")
	local comps = EntityGetAllComponents(entity) or {}
	for i = 1, #comps do
		if ComponentHasTag(comps[i], "graham_speech_removable") then
			EntityRemoveComponent(entity, comps[i])
		end
	end
end

---@param entity integer	
---@param effects string[]
---@return boolean
function EntityHasGameEffect(entity, effects)
	local queue = EntityGetAllChildren(entity) or {}
	local last = #queue
	local current = 1
	local checks = {}
	for i = 1, #effects do checks[effects[i]] = true end
	while current <= last do
		local check_entity = queue[current]
		local comps = EntityGetComponent(check_entity, "GameEffectComponent") or {}
		for i = 1, #comps do
			if checks[ComponentGetValue2(comps[i], "effect")] then return true end
		end
		local children = EntityGetAllChildren(check_entity) or {}
		local new = #children
		for i = 1, new do
			queue[i + last] = children[i]
		end
		last = last + new
		current = current + 1
	end
	return false
end

function EntityIsStunned(entity)
	if EntityHasGameEffect(entity, {"FROZEN"}) and not EntityHasGameEffect(entity, {"STUN_PROTECTION_FREEZE"}) then return true end
	if EntityHasGameEffect(entity, {"ELECTROCUTION"}) and not EntityHasGameEffect(entity, {"STUN_PROTECTION_ELECTRICITY"}) then return true	end
	return false
end

---Returns the spoken text if enemy successfully began speaking. Otherwise, returns nil.
---@param entity number
---@param text string
---@param pool pool
---@param check_name boolean? true
---@param override_old boolean? false
---@param name_override string? -- This is for custom stuff, generally shouldn't be needed
---@return string?
function Speak(entity, text, pool, check_name, override_old, name_override)
	override_old = override_old or false
	pool = pool or pools.GENERIC
	if check_name == nil then check_name = true end

	local textComponent = EntityGetFirstComponentIncludingDisabled(entity, "SpriteComponent", "graham_speech_text")
	if textComponent and not override_old then return end

	local rotate = false
	local old_text = text
	local x, y = EntityGetTransform(entity)
	SetRandomSeed(entity + x + 2352, GameGetFrameNum() - y + 24806)
	local size_x = 0.65
	local size_y = 0.65

	local alpha = (100 - ModSettingGet("grahamsdialogue.transparency")) / 100
	local name = NameGet(entity)
	if name_override ~= nil then
		name = DUPES[name_override] or name_override
	end
	local offset_y = 28 + ((Special_offsets_y[name] or 0) * 1.2)
	local font = "font_pixel_white"
	local custom_font = false

	if check_name then --!!!--
		if not (EntityHasTag(entity, "graham_enemydialogue") or EnemyHasDialogue(pools.ANY, name) or name_override ~= nil) then return end
		-- player should never speak
		if EntityHasTag(entity, "player_unit") or EntityHasTag(entity, "player_polymorphed") or EntityHasTag(entity, "polymorphed_player") then return end
		if EntityIsStunned(entity) then return end

		local genome = EntityGetFirstComponent(entity, "GenomeDataComponent")
		local faction
		if genome ~= nil then
			faction = HerdIdToString(ComponentGetValue2(genome, "herd_id"))
		end

		--- SPECIAL FUNCTIONALITY ---

		-- Copier mage should go at the top, so it can pretend to be a different enemy
		if name == "$animal_wizard_returner" then
			local thing = nil
			if pool == pools.IDLE then thing = DIALOGUE_IDLE end
			if pool == pools.DAMAGEDEALT then thing = DIALOGUE_DAMAGEDEALT end
			if pool == pools.DAMAGETAKEN then thing = DIALOGUE_DAMAGETAKEN end
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

		Special_dialogue = dofile_once("mods/grahamsdialogue/files/special_dialogue.lua")

		local worm_speeds = {
			["$animal_worm_tiny"]   = 6,
			["$animal_worm"]        = 7,
			["$animal_worm_big"]    = 8,
			["$animal_boss_dragon"] = 20,
			["$animal_worm_skull"]  = 10,
			["$animal_worm_end"]    = 10,
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
		if Special_dialogue[name] ~= nil then
			local config = {
				text = text,
				entity = entity,
				x = x,
				y = y,
				size_x = size_x,
				size_y = size_y,
				faction = faction,
				pool = pool,
				font = font,
				custom_font = custom_font
			}
			Special_dialogue[name](config)
			text = config.text
			entity = config.entity
			x = config.x
			y = config.y
			size_x = config.size_x
			size_y = config.size_y
			faction = config.faction
			pool = config.pool
			font = config.font
			custom_font = config.custom_font
		end

		if Special_sizes[name] ~= nil then
			size_x = size_x + Special_sizes[name]
			size_y = size_y + Special_sizes[name]
		end
		if EntityHasTag(entity, "robot") then
			size_x = size_x + 0.06
		end
		if EntityHasTag(entity, "boss") or EntityHasTag(entity, "miniboss") then
			size_x = size_x + 0.10
			size_y = size_y + 0.10
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
				_tags = "graham_speech_removable",
				execute_every_n_frame = 1,
				script_source_file = "mods/grahamsdialogue/files/ghost.lua"
			})
		end
	end                                       --!!!--

	if text == "" or text == nil then return end -- utility; if text is nothing then don't speak at all

	if ModIsEnabled("translation_uwu") then   -- Haunted
		dofile_once("mods/translation_uwu/init.lua")
		---@diagnostic disable-next-line: undefined-global
		text = owoify(text)
	end
	-- if ModIsEnabled("salakieli") then font = "/mods/grahamsdialogue/files/font_runes_white.xml" end
	-- i don't think this is needed because salakieli overrides already.
	-- TODO: new font system means we need to do this properly.
	if GameGetGameEffectCount(entity, "CONFUSION") > 0 then text = string.reverse(text) end -- thanks sycokinetic for telling me about string.reverse lol

	---- All dialogue handling should go above this point, don't tinker with stuff down here ----
	local mode = (ModSettingGet("grahamsdialogue.type") == "letter" and string.sub(text, 1, 1)) or text

	if override_old then RemoveCurrentDialogue(entity) end
	local size = ModSettingGet("grahamsdialogue.scale")
	size_x = size_x * size
	size_y = size_y * size

	local gui = GuiCreate()
	GuiStartFrame(gui)
	local width = 0
	if custom_font then
		width = dofile("mods/grahamsdialogue/files/custom_font.lua")(font, mode)
	else
		width = GuiGetTextDimensions(gui, mode, 1) / 2 -- special scale after offset_x
	end
	GuiDestroy(gui)

	EntityAddTag(entity, "graham_speaking")
	EntityAddComponent2(entity, "SpriteComponent", {
		_tags = "enabled_in_world, graham_speech_text, graham_speech_removable",
		image_file = "mods/grahamsdialogue/files/font_data/" .. font .. ".xml",
		emissive = ModSettingGet("grahamsdialogue.visibility"),
		is_text_sprite = true,
		offset_x = width,
		offset_y = offset_y,
		alpha = alpha,
		update_transform = true,
		update_transform_rotation = rotate,
		text = mode,
		has_special_scale = true,
		special_scale_x = size_x,
		special_scale_y = size_y,
		z_index = -9000,
		never_ragdollify_on_death = true
	})

	local luacomp = EntityGetFirstComponentIncludingDisabled(entity, "LuaComponent", "graham_speech_quiet")
	if luacomp then EntityRemoveComponent(entity, luacomp) end

	EntityAddComponent2(entity, "VariableStorageComponent", {
		_tags = "graham_speech_removable",
		name = "graham_dialogue_storage",
		value_string = text,
		value_int = 1,
	})
	EntityAddComponent2(entity, "LuaComponent", {
		_tags = "graham_speech_removable",
		execute_every_n_frame = 1,
		script_source_file = "mods/grahamsdialogue/files/speak.lua",
	})

	return text
end
