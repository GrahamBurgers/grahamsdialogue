---@diagnostic disable: undefined-global
return {
	["$animal_necromancer_shop"] = function(config)
		if config.pool == "IDLE" and GlobalsGetValue("TEMPLE_PEACE_WITH_GODS") == "1" then
			local special = {
				"I suppose I can let it slide. But just this once!",
				"Don't think that this means that you're off the hook...",
				"Fine... harumph.",
			}
			config.text = special[Random(1, #special)]
		end
	end,
	["$animal_necromancer_super"] = function(config)
		if config.pool == "IDLE" and GlobalsGetValue("TEMPLE_PEACE_WITH_GODS") == "1" then
			local special = {
				"A sinful being you are... But perhaps a little bit endearing.",
				"Don't be mistaken. It is by command of the gods that I spare your life today.",
				"I'm sure you have your reasons. But so do I.",
			}
			config.text = special[Random(1, #special)]
		end
	end,
	["$animal_firemage"] = function(config)
		if config.pool == "IDLE" then
			local items = EntityGetInRadiusWithTag(x, y, 180, "item_pickup")
			for i = 1, #items do
				local comps = EntityGetComponent(items[i], "GameEffectComponent", "enabled_in_hand") or {}
				for j = 1, #comps do
					if ComponentGetValue2(comps[j], "effect") == "FRIEND_FIREMAGE" then
						local special = {
							"What an interesting stone. I can't help but stare.",
							"That flame burns brightly. Not as bright as me, but still...",
							"Blue fire is all the rage nowadays. Normal fire, not so much.",
						}
						config.text = special[Random(1, #special)]
						return
					end
				end
			end
		end
	end,
	["$animal_firemage_weak"] = function(config)
		if config.pool == "IDLE" then
			local items = EntityGetInRadiusWithTag(config.x, config.y, 180, "item_pickup")
			for i = 1, #items do
				local comps = EntityGetComponent(items[i], "GameEffectComponent", "enabled_in_hand") or {}
				for j = 1, #comps do
					if ComponentGetValue2(comps[j], "effect") == "FRIEND_FIREMAGE" then
						local special = {
							"Nice stone you got there. Is it for sale?",
							"That flame... it reminds me of myself when I was younger.",
							"Come a bit closer. I'd like to get a better look at that item.",
						}
						config.text = special[Random(1, #special)]
						return
					end
				end
			end
		end
	end,
	["$animal_thundermage"] = function(config)
		if config.pool == "IDLE" then
			local items = EntityGetInRadiusWithTag(config.x, config.y, 180, "item_pickup")
			for i = 1, #items do
				local comps = EntityGetComponent(items[i], "GameEffectComponent", "enabled_in_hand") or {}
				for j = 1, #comps do
					if ComponentGetValue2(comps[j], "effect") == "FRIEND_THUNDERMAGE" then
						local special = {
							"What a beautiful stone. Take good care of it.",
							"It looks like you appreciate the art of electricity almost as much as I do.",
							"I would normally blast you to pieces, but...",
						}
						config.text = special[Random(1, #special)]
						return
					end
				end
			end
		end
	end,
	["$animal_thunderskull"] = function(config)
		if (config.pool == "DAMAGEDEALT" or config.pool == "DAMAGETAKEN") and GameHasFlagRun("PERK_PICKED_ELECTRICITY") then
			local special = {
				"Yo! A fellow electricity user?!",
				"I never expected to see someone as rad as me down here!",
				"I'm a fan of the volts you're outputting, friend.",
			}
			config.text = special[Random(1, #special)]
		end
	end,
	["$animal_iceskull"] = function(config)
		if (config.pool == "DAMAGEDEALT" or config.pool == "DAMAGETAKEN") and GameHasFlagRun("PERK_PICKED_GRAHAM_REVENGE_FREEZE") then
			local special = {
				"Hey, you also have retaliation projectiles? N-ice.",
				"Your perks are cool! And I mean that literally.",
				"We should make some ice sculptures together, some time.",
			}
			config.text = special[Random(1, #special)]
		end
	end,
	["$animal_icemage"] = function(config)
		if (config.pool == "DAMAGEDEALT" or config.pool == "DAMAGETAKEN") and GameHasFlagRun("PERK_PICKED_FREEZE_FIELD") then
			local special = {
				"Ice skate with me, friend!",
				"Are you feeling that winter spirit?",
				"I get stuck in ice so often. What are your secrets?",
			}
			config.text = special[Random(1, #special)]
		end
	end,
	["$animal_giant"] = function(config)
		local enemies = EntityGetInRadiusWithTag(config.x, config.y, 140, "glue_NOT")
		for i = 1, #enemies do
			if EntityGetName(enemies[i]) == "$animal_pebble" then
				Speak(enemies[i], config.text, config.pool)
			end
		end
	end,
	["$animal_graham_fuzz"] = function(config)
		if config.faction == "player" and config.pool == "IDLE" then
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
			config.text = special[Random(1, #special)]
		end
		return config.text
	end,
	["$animal_pebble"] = function(config)
		config.size_x = config.size_x - 0.8
		config.size_y = config.size_y - 0.8
	end,
	["$animal_miniblob"] = function(config)
		config.size_x = config.size_x - 0.10
		config.size_y = config.size_y - 0.10
	end,
	["$animal_lukki_tiny"] = function(config)
		config.size_x = config.size_x - 0.05
		config.size_y = config.size_y - 0.05
	end,
	["$animal_miner_santa"] = function(config)
		if StatsBiomeGetValue("enemies_killed") < 1 and config.pool == "DAMAGEDEALT" then
			local special = {
				"Pacifism? You might be deserving of the Nice List after all.",
				"You've been a good person so far. Christmas awaits!",
				"Finally... someone that can appreciate the holiday spirit.",
			}
			config.text = special[Random(1, #special)]
		end
	end,
	["$graham_lukkimount_name"] = function(config)
		local who = ComponentGetValue2(EntityGetFirstComponent(config.entity, "VariableStorageComponent") or 0,
			"value_int")
		if who == 0 or who == nil then config.text = "" end
		if BiomeMapGetName(config.x, config.y) == "$biome_rainforest" and Random(1, 3) == 1 and config.pool == "IDLE" then
			local special = {
				"Ah, it's nice to be home in the jungle.",
				"It really has been a while. I don't recognize anyone here...",
				"Can we stay here a bit longer? I've missed it dearly...",
				"The air is so fresh here. It's a bit strange.",
				"Compared to everything else underneath the mountain, this place is...",
				"I'm enjoying just exploring the world with you. Though it's nice to be home.",
			}
			config.text = special[Random(1, #special)]
		end
	end,
	["$animal_lurker"] = function(config)
		EntityAddComponent2(config.entity, "LuaComponent", {
			_tags = "graham_speech_removable",
			execute_every_n_frame = 1,
			script_source_file = "mods/grahamsdialogue/files/lurker.lua"
		})
	end,
	["$animal_lukki_dark"] = function(config)
		config.size_x = config.size_x + 0.20
		config.size_y = config.size_y + 0.20
		if string.sub(config.text, -1, -1) == "." and string.sub(config.text, -2, -2) ~= "." then
			config.text = string.sub(config.text, 1, -2) .. "!"
		end
	end,
	["$animal_worm_end"] = function(config)
		config.size_x = config.size_x + 0.15
		config.size_y = config.size_y + 0.15
	end,
	["$animal_boss_dragon"] = function(config)
		config.size_x = config.size_x + 0.10
		config.size_y = config.size_y + 0.10
	end,
}
