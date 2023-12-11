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
				special[#special+1] = "A fellow spider has more than 3 health? No fair."
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
			local items = EntityGetInRadiusWithTag(config.x, config.y, 180, "item_pickup")
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
			_tags = "graham_speech_removable,graham_speech_lurker",
			execute_every_n_frame = 1,
			script_source_file = "mods/grahamsdialogue/files/custom/lurker.lua"
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
		local is_in_endroom = #EntityGetInRadiusWithTag(config.x, config.y, 200, "victoryroom_ambience") ~= 0
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
	["$animal_boss_wizard"] = function(config)
		local comp = EntityGetFirstComponent( config.entity, "VariableStorageComponent", "boss_wizard_mode" )
		local special = {}
		if comp ~= nil then
			local mode = ComponentGetValue2( comp, "value_int" )
			local chance = 6
			if mode == 1 then chance = 4 end
			if mode == 2 then chance = 2 end
			if (config.pool == pools.IDLE or Random(1, chance) == chance) then
				if EntityHasGameEffect(EntityGetClosestWithTag(config.x, config.y, "player_unit"), { "PROTECTION_ALL" }) and Random(1, 3) == 3 then
					special[#special+1] = "You little cheater. You want to have it both ways, don't you?"
					special[#special+1] = "I see you over there. Do you need invincibility to beat me? How amusing."
					special[#special+1] = "Interesting. I worked hard for my power... And here you are. Invulnerable."
				end
				if mode == 0 then
					-- normal
					if #EntityGetInRadiusWithTag(config.x, config.y, 128, "wizard_orb_death") < 1 then
						special[#special+1] = "You've subverted just one aspect of my magic. I wouldn't celebrate just yet."
						special[#special+1] = "What a shame you didn't shoot the red ones as well. It's not too late..."
						special[#special+1] = "Oh? Something feels different... My invincibility is gone. No matter."
					end
					if GameHasFlagRun("$animal_gate_monster_a_killed") and GameHasFlagRun("$animal_gate_monster_b_killed")
					and GameHasFlagRun("$animal_gate_monster_c_killed") and GameHasFlagRun("$animal_gate_monster_d_killed")
					and Random(1, 3) == 3 then
						special[#special+1] = "You've destroyed the triangular guardians as well? That explains some things..."
					end
				elseif mode == 1 then
					-- helmet gone
					special[#special+1] = "Bear witness to my true form. I tried to hide it, but no longer."
					special[#special+1] = "Oh, you've done it now... Prepare to meet your end."
					special[#special+1] = "The pain is almost unbearable now. Let me share some of it with you."
				elseif mode == 2 then
					-- tentacle frenzy
					special[#special+1] = "I don't care anymore! I'll rip you apart, even if it kills me!"
					special[#special+1] = "You accursed being of magic...! You deserve nothing but pain!"
					special[#special+1] = "Gods, oh Gods... Grant me power to give this fool what they deserve!"
					config.size_x = config.size_x + 0.06
					config.size_y = config.size_y + 0.06
				end
			end
		end
		if #special > 0 then
			config.text = special[Random(1, #special)]
		end
	end,
	["$animal_boss_ghost"] = function(config)
		local eyes = EntityGetInRadiusWithTag( config.x, config.y, 200, "evil_eye" )
		local found = false
		for i = 1, #eyes do
			if (EntityGetFirstComponent( eyes[i], "LightComponent", "magic_eye_check" )) then
				found = true
				break
			end
		end
		if not found then
			config.size_x = config.size_x - 0.10
			config.size_y = config.size_y - 0.10
			local special = {
				"Concealed, sealed power...",
				"No light enters. None leaves.",
				"I see you. You don't fool me...",
			}
			config.text = special[Random(1, #special)]
		elseif Random(1, 3) == 1 and config.pool == pools.IDLE then
			if HasFlagPersistent( "moon_is_sun" ) and HasFlagPersistent( "darkmoon_is_sun" ) then config.text         = "The suns... The world is bathed in light. What have you done?" end
			if HasFlagPersistent( "moon_is_darksun" ) and HasFlagPersistent( "darkmoon_is_darksun" ) then config.text = "The suns... The world is shrouded in darkness. What have you done?" end
			if HasFlagPersistent( "moon_is_sun" ) and HasFlagPersistent( "darkmoon_is_darksun" ) then config.text     = "The suns... The world is balanced at last. You have done well." end
			if HasFlagPersistent( "moon_is_darksun" ) and HasFlagPersistent( "darkmoon_is_sun" ) then config.text     = "The suns... Something feels off. This is not what our Gods wanted." end
		end
	end,
	["$animal_boss_ghost_polyp"] = function(config)
		local eyes = EntityGetInRadiusWithTag( config.x, config.y, 200, "evil_eye" )
		local found = false
		for i = 1, #eyes do
			if (EntityGetFirstComponent( eyes[i], "LightComponent", "magic_eye_check" )) then
				found = true
				break
			end
		end
		if not found then
			config.size_x = config.size_x - 0.10
			config.size_y = config.size_y - 0.10
			local special = {
				"Who turned out the lights...?",
				"We thought things would change...",
				"We've all gone blind.",
			}
			config.text = special[Random(1, #special)]
		end
	end,
	["$animal_boss_centipede"] = function(config)
		if ModSettingGet("grahamsdialogue.hamis") and ModIsEnabled("Hamisilma") and config.text then
			local new = string.lower(config.text)
			if string.sub(config.text, -1, -1) == "." and string.sub(config.text, -2, -2) ~= "." then
				new = string.sub(config.text, 1, -2)
			end
			config.text = new
		end
		local special = {}
		if Random(1, 3) == 1 and config.pool == pools.IDLE then
			if config.y < -7000 or config.y > 15000 then
				special[#special+1] = "Where on earth are we...? Why have you gone here?"
				special[#special+1] = "Are you leading me somewhere? What could you possibly..."
				special[#special+1] = "What are you doing? I'd rather not take a world tour..."
			end
			if math.abs(config.x) > 20000 then
				special[#special+1] = "Something calls to me... I do not belong here. Not at all."
				special[#special+1] = "Oh, no... I do not like this place. Can we go back, please?"
				special[#special+1] = "I'm can follow you, but... This is going a bit far. Literally."
			end
		end
		if #special > 0 then
			config.text = special[Random(1, #special)]
		end
		if (config.pool ~= pools.CUSTOM and (GlobalsGetValue( "FINAL_BOSS_ACTIVE", "0") ~= "1") and not ComponentGetValue2(EntityGetFirstComponent(GameGetWorldStateEntity(), "WorldStateComponent") or 0, "ENDING_HAPPINESS")) then config.text = nil end
		-- config.text = nil -- TEMP TEMP TEMP
	end,
	["$animal_wizard_poly"] = function(config)
		local player = EntityGetClosestWithTag(config.x, config.y, "player_unit")
		if (config.pool == pools.DAMAGEDEALT or config.pool == pools.DAMAGETAKEN) and EntityHasGameEffect(player, { "PROTECTION_POLYMORPH" } ) then
			local special = {
				"Oh, you're immune? Cute. I'll get to you soon enough.",
				"We'll see how confident you are once that timer runs out...",
				"Little cheater. My magic doesn't work on you... For now.",
			}
			config.text = special[Random(1, #special)]
		end
	end,
	["$animal_wizard_dark"] = function(config)
		if (config.pool == pools.DAMAGEDEALT or config.pool == pools.DAMAGETAKEN) and GameHasFlagRun("PERK_PICKED_GRAHAM_BLIND_SPOT") and Random(1, 2) == 2 then
			local special = {
				"What's going wrong...? I can't see you!",
				"I don't understand... You're immune? How?!",
				"Something's happened... My magic isn't working!",
			}
			config.text = special[Random(1, #special)]
		end
	end,
}
-- reminder: default speak_end_wait_frames is 180
