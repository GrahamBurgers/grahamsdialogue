--dofile("mods/grahamsdialogue/files/common.lua")
return {
	["$animal_longleg"] = function(config)
		local new = config.text
		if Random(1, 7) == 7 then
			local special = {}
			if ModIsEnabled("HamisMaid") then
				special[#special+1] = "This outfit... I feel like it was meant to be."
			end
			if ModIsEnabled("cowboy_hamis") then
				special[#special+1] = "This hat... I'm feelin' real good about this!"
			end
			if ModIsEnabled("rainbow_hamis") or ModIsEnabled("rainbow_hamogus") then
				special[#special+1] = "Every color of the rainbow is reflected in our beauty."
			end
			if ModIsEnabled("hamogus") or ModIsEnabled("rainbow_hamogus") or ModIsEnabled("hamisus") then
				special[#special+1] = "I'm feeling kind of sus... B-but I'm no impostor!"
			end
			if ModIsEnabled("cool hamis") then
				special[#special+1] = "This cigarette is fake... But it does make me look cooler."
			end
			if ModIsEnabled("Copis_Hamis_Friends") then
				special[#special+1] = "You, player! You're a friend, in more ways than one..."
			end
			if ModIsEnabled("longleg_player") then
				special[#special+1] = "A fellow sibling has more than 3 health? No fair."
			end
			if #special > 0 then
				new = special[Random(1, #special)]
			end
		end
		if ModSettingGet("grahamsdialogue.hamis") then
			new = string.lower(new)
			if string.sub(config.text, -1, -1) == "." and string.sub(config.text, -2, -2) ~= "." then
				new = string.sub(new, 1, -2)
			end
		end
		config.text = new
	end,
	["$animal_necromancer_shop"] = function(config)
		if config.pool == pools.IDLE and GlobalsGetValue("TEMPLE_PEACE_WITH_GODS") == "1" then
			local special = {
				"I suppose I can let it slide. But just this once!",
				"Don't think that this means that you're off the hook...",
				"Fine... harumph.",
			}
			config.text = special[Random(1, #special)]
		end
	end,
	["$animal_necromancer_super"] = function(config)
		if config.pool == pools.IDLE and GlobalsGetValue("TEMPLE_PEACE_WITH_GODS") == "1" then
			local special = {
				"A sinful being you are... But perhaps a little bit endearing.",
				"Don't be mistaken. It is by command of the gods that I spare your life today.",
				"I'm sure you have your reasons. But so do I.",
			}
			config.text = special[Random(1, #special)]
		end
	end,
	["$animal_firemage"] = function(config)
		if config.pool == pools.IDLE then
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
		if config.pool == pools.IDLE then
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
	["$animal_thundermage_big"] = function(config)
		if config.pool == pools.IDLE then
			local items = EntityGetInRadiusWithTag(config.x, config.y, 180, "item_pickup")
			for i = 1, #items do
				local comps = EntityGetComponent(items[i], "GameEffectComponent", "enabled_in_hand") or {}
				for j = 1, #comps do
					if ComponentGetValue2(comps[j], "effect") == "FRIEND_THUNDERMAGE" then
						local special = {
							"Argh... That stone... Drop it so I can eviscerate you!",
							"Oh, you know that I don't want to destroy that item, hmm? Clever.",
							"How about we barter. You give me that stone, and I'll spare your life. Hah...",
						}
						config.text = special[Random(1, #special)]
						return
					end
				end
			end
		end
	end,
	["$animal_thundermage"] = function(config)
		if config.pool == pools.IDLE then
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
		if (config.pool == pools.DAMAGEDEALT or config.pool == pools.DAMAGETAKEN) and GameHasFlagRun("PERK_PICKED_ELECTRICITY") then
			local special = {
				"Yo! A fellow electricity user?!",
				"I never expected to see someone as rad as me down here!",
				"I'm a fan of the volts you're outputting, friend.",
			}
			config.text = special[Random(1, #special)]
		end
	end,
	["$animal_iceskull"] = function(config)
		if (config.pool == pools.DAMAGEDEALT or config.pool == pools.DAMAGETAKEN) and GameHasFlagRun("PERK_PICKED_GRAHAM_REVENGE_FREEZE") then
			local special = {
				"Hey, you also have retaliation projectiles? N-ice.",
				"Your perks are cool! And I mean that literally.",
				"We should make some ice sculptures together, some time.",
			}
			config.text = special[Random(1, #special)]
		end
	end,
	["$animal_icemage"] = function(config)
		if (config.pool == pools.DAMAGEDEALT or config.pool == pools.DAMAGETAKEN) and GameHasFlagRun("PERK_PICKED_FREEZE_FIELD") then
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
		if config.faction == "player" and config.pool == pools.IDLE then
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
	["$animal_miner_santa"] = function(config)
		if StatsBiomeGetValue("enemies_killed") < 1 and config.pool == pools.DAMAGEDEALT then
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
		if BiomeMapGetName(config.x, config.y) == "$biome_rainforest" and Random(1, 3) == 1 and config.pool == pools.IDLE then
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
		if string.sub(config.text, -1, -1) == "." and string.sub(config.text, -2, -2) ~= "." then
			config.text = string.sub(config.text, 1, -2) .. "!"
		end
	end,
	["generic_ghost"] = function(config)
		config.faction = "ghost"
	end,
	["$animal_friend"] = function(config)
		if config.pool == pools.IDLE or Random(1, 2) == 1 then
			local count = tonumber(GlobalsGetValue("ULTIMATE_KILLER_KILLS", "0"))
			if count >= 10 then
				local special = {
					"I will never forgive you for what you've done.",
					"You think I'm funny? I'm being serious right now.",
					"What's wrong with you? Why would you do that?",
					"You deserve death after what you did to my children.",
					"What do you plan to do to me? I don't trust you.",
					"I hate you. I seriously hate you.",
				}
				config.text = special[Random(1, #special)]
			elseif count >= 1 then
				local special = {
					"I have to stop you before you do any more harm!",
					"Don't act like that was an accident. I know you.",
					"It's no magic that makes me stronger. Just rage.",
					"Don't you dare continue that behaviour any further.",
					"I should have never let you in here to begin with.",
					"Stay back, children! I'll take care of this.",
				}
				config.text = special[Random(1, #special)]
			end
		end
	end,
	["karl"] = function(config)
		if EntityHasTag(config.entity, "small_friend") and Random(1, 3) > 1 then
			local special = {
				"I don't know what this thing is, but it seems to like me. (Hello!)",
				"(This cart is cool!) Heh, I'm glad you think so, kid.",
				"Sit back and relax. This'll be a smooth ride. (Thanks!)",
				"(Where are we going?) Not sure yet. Stick around and see, eh?",
				"You two are quite interesting creatures... (Yeah!)",
				"I'm glad to meet a creature as kind as myself. (Me too!)",
			}
			config.text = special[Random(1, #special)]
		end
	end,
	["$animal_ethereal_being"] = function(config)
		if EntityGetFirstComponent(config.entity, "SpriteComponent") ~= EntityGetFirstComponentIncludingDisabled(config.entity, "SpriteComponent") then
			config.size_x = config.size_x - 0.10
			config.size_y = config.size_y - 0.10
			local special = {
				"Whispers on the wind...",
				"Do you hear that? Come closer...",
				"Ha, ha... The thought terrifies me.",
				"The chill of death never truly leaves.",
			}
			config.text = special[Random(1, #special)]
		end
	end,
	["$animal_fish_giga"] = function(config)
		config.font = "font_pixel_huge" -- arial
		config.custom_font = true
	end,
	["Calamariface"] = function(config)
		local special
		local x, y = EntityGetTransform(config.entity)
		local is_in_endroom = #EntityGetInRadiusWithTag(x, y, 200, "victoryroom_ambience") ~= 0
		if GameHasFlagRun("lap3_now") then
			special = {
				"If it's death you want, I'm glad to provide.",
				"A delightful dose of overconfidence spells your demise.",
				"The shortest path to your death is always a straight line.",
				"You must be insane to attempt a challenge like this.",
				"Run faster! Faster! I'll get to you soon enough...",
				"Lap 2 just wasn't enough for you, eh? So be it...",
			}
			if is_in_endroom then
				config.speak_end_wait_frames = "900000"
				special = {
					"You actually outran me...?! Blasphemy!",
					"Who do you think you are?! I'll rip you to pieces!",
					"No way! You cheated! No one outruns Calamariface!",
				}
			end
		elseif is_in_endroom then
			config.speak_end_wait_frames = "360"
			special = {
				"Hmm. Fine. You win this time. Next time, though...",
				"Care for a real challenge? I bet you can't beat me in Lap 3.",
				"Well done. You did the bare minimum to survive...",
			}
		end
		if #EntityGetWithTag("player_unit") < 1 then
			config.speak_end_wait_frames = "900000"
			special = {
				"Hah. Maybe next time. Or maybe not.",
				"You knew that this was always the way it was going to end.",
				"I win this time. Don't tell me you expected anything different.",
			}
		end
		if special ~= nil then
			config.text = special[Random(1, #special)]
		end
	end,
	["$animal_homunculus"] = function(config)
		local comp = EntityGetFirstComponent(config.entity, "DamageModelComponent")
		if comp ~= nil then
			local max_hp = ComponentGetValue2(comp, "max_hp")
			if max_hp < 0 then
				local special = {
					"Hold on.... What if I just kill you myself?!",
					"I feel like being a villain today...",
					"I want to kill something tougher... Like you!",
				}
				config.text = special[Random(1, #special)]
			end
		end
	end,
	["$animal_rat"] = function(config)
		if EntityHasTag(config.entity, "plague_rat") then
			config.size_x = config.size_x - 0.08
			config.size_y = config.size_y - 0.08
			local special = {
				"Stay among the rats too long, and you might just become one...",
				"Stay away from pheromone. You belong to the rats now!",
				"A rat's eyes pierce the dark like nothing else.",
				"All that lies below the mountain belongs to us! Raah!",
				"How come we don't get to fly, too? It's so unfair!",
				"Where's the giant rat that makes all of the rules?",
			}
			config.text = special[Random(1, #special)]
		end
	end,
}
