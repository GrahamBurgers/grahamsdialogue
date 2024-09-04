---@diagnostic disable: undefined-field, undefined-doc-name, lowercase-global
if GlobalsGetValue("FINAL_BOSS_ACTIVE", "0") == "1" and not ComponentGetValue2(EntityGetFirstComponent(GameGetWorldStateEntity(), "WorldStateComponent") or 0, "ENDING_HAPPINESS") then return end

dofile_once("mods/grahamsdialogue/files/common.lua")
dofile_once("mods/grahamsdialogue/files/types.lua")
local choice = GlobalsGetValue("GRAHAM_KOLMI_SPEECH", "error")
local offset = tonumber(GlobalsGetValue("GRAHAM_KOLMI_OFFSET", "0"))
local frames = tonumber(GlobalsGetValue("GRAHAM_KOLMI_FRAMES", "0"))
local amount = tonumber(GlobalsGetValue("GRAHAM_KOLMI_PROGRESS", "1"))
local x, y = EntityGetTransform(GetUpdatedEntityID())
local orbs = GameGetOrbCountThisRun()

-- thank you nathan for making the code here much better
---@type line_pool
local lines = {
	["none"] = {
		{ weight = 0.01, lines = { "Who'd put this much effort into a cosmetic mod?", "It doesn't even affect gameplay! What gives?" } },
		{ weight = 0.30, lines = { "Hello there, eternal one.", "...May I have a few more moments before we battle, please?", "I accepted my fate a long time ago. But...", "It can feel gratifying to delay the inevitable, no?", "Just... Sit here with me for a moment." } },
		{ weight = 0.30, lines = { "Ahem. \"Time and time again,", "I fight. I win or I lose.", "It all ends the same.\"", "...That's a haiku I wrote about you.", "I have to find some ways to keep myself busy, you know!", "Well. Are you ready for the main event?" } },
		{ weight = 0.30, lines = { "Ah! You showed up this time. I'm... glad, I think.", "It's rather eerie. Sometimes you never arrive down here.", "I just sit, wait, and tinker, until everything goes dark again.", "Though, I guess it's still better than the alternative.", "Death isn't exactly a painless process, as I'm sure you know..." } },
		{ weight = 0.30, lines = { "...You know, this device isn't just a simple cog.", "You do not see it in the way that I do. It can work wonders, but...", "It requires the proper knowledge and care.", "Neither of which you seem to possess. No offense.", "Ah, well. I suppose I can't convince you.", "Let's fight, then. Perhaps I'll win this time." } },
		{ weight = 0.30, lines = { "Greetings. Did you have a nice journey?", "I don't particularly care. But I enjoy making you think.", "Even if you kill me ten, or a million, or a billion times...", "I just don't want it to become a thoughtless activity for you.", "That's why... I never give up.", "No matter how bleak things seem." } },
	},
	["pacifist"] = {
		{ weight = 3.00, lines = { "You've changed your ways. How interesting.", "Relentless killing, replaced by pacifism...", "Oh, but it's the same person beneath, isn't it?", "The others don't see it, but I do. It's clear as crystal.", "You're corrupt inside. Malicious. Irreversably so.", "How ironic indeed." } },
		{ weight = 3.00, lines = { "Interesting. How very implausible...", "You've managed to subdue your murderous tendencies.", "For one simple run, at the very least...", "My apologies. I can hold a bit of a grudge.", "I'm sure you've already forgotten the many deaths you've given me..." } },
		{ weight = 3.00, lines = { "Hmm. This feels a bit futile, doesn't it?", "No matter what, our deaths mark the end of this world...", "Sparing the lives of a few creatures won't change that.", "Though I appreciate the gesture... I distrust your intentions.", "Would you really ever think of others before yourself?" } },
		{ weight = 3.00, lines = { "Even after so many runs... I just can't predict you.", "You kill them all. Spare them all. Give up, sometimes.", "You're the only creature I've met that... changes.", "I wish I could know more. You speak, but...", "I cannot hear you. Not through the screen." } },
	},
	["damageless"] = {
		{ weight = 6.00, lines = { "Hah. You amuse me, familiar one.", "Not a single point of damage taken? Impressive.", "Let's see if I can't change that for you, eh?", "It's only fair, after the countless deaths you've given me..." } },
		{ weight = 6.00, lines = { "You are quite the little showoff, aren't you?", "Not a single scratch on you, I see...", "I won't deny the skill involved, but...", "Don't you have anything better to do?" } },
		{ weight = 6.00, lines = { "Aren't you an expert at dying? How did you manage to...", "Ah, whatever. I'm probably overthinking it.", "You used ambrosia, or shields, or something. Right...?", "How on earth have you not taken a single hit?", "Whatever. Your little games do nothing but confound me.", "Let's just end this. One way or another." } },
	},
	["speedrun"] = {
		{ weight = 2.00, lines = { "Ah. You arrived here... Sooner than I expected.", "Oh, but don't let me slow you down, little one.", "I'll let you win, and then you can be on your way...", "Just kidding. I'm not going to hold back.", "Your little speedrun means nothing to me." } },
		{ weight = 3.00, lines = { "Curious. You're... Rather quick, aren't you?", "Well, don't bother listening to my ramblings, eh?", "I already know what you're here for.", "Let's just make this quick." } },
		{ weight = 1.00, lines = { "I think I understand you a bit better, now.", "You enjoy a challenge, yes? Something to keep you busy...", "I cannot guarantee that I'll be what you desire, but...", "If this is what it takes... Then I shall fight." } },
		{ weight = 1.00, lines = { "Hello there. I think you're here early.", "Not that I'm one to complain. It's all the same to me.", "Although I'd appreciate it if you let me finish my work for once...", "Ah, well. I'm ready when you are." } },
		{ weight = 1.00, lines = { "You think you're fast? I've seen better.", "And once I end your life... Heheh.", "This whole run will have been a waste of time." } },
	},
	["notinkering"] = {
		{ weight = 4.00, lines = { "Eh? No tinkering? That's rather odd.", "Such magic at your disposal, and you reject it...", "Well. I suppose I shan't complain.", "It makes your death more likely, to say the least.", "That is something I will always welcome." } },
		{ weight = 3.00, lines = { "Hello there. What are you doing this time?", "I thought wands were... Quite important to you.", "To lose the ability to edit them must be tough.", "Oh, no. Do not mistake my curiosity for empathy.", "I will end you all the same." } },
		{ weight = 3.00, lines = { "You're not editing your wands... I see.", "Did you think that I would be impressed? That's wishful thinking.", "I think it to be a foolish endeavour. Unnecessary, even.", "Though I doubt you care about anything that I have to say.", "Just try to kill me, then. With your pathetic wands..." } },
	},
	["glasscannon"] = {
		{ weight = 1.00, lines = { "You seem rather explosive today. Are you alright?", "I wouldn't want to get caught up in your destructive tendencies.", "Though, something tells me that I'm about to be..." } },
		{ weight = 1.00, lines = { "Oh. I see. All or nothing, is that the idea?", "I'm a bit surprised that you haven't blown yourself up yet.", "Well, this fight may go quicker than most of our previous fights.", "Let's see if we can't make it memorable, though, eh?" } },
	},
	["wandcapacity"] = {
		{ weight = 5.00, lines = { "Heheh... That perk that you have there... I recognize it.", "\"Wand Capacity +\". I remember the path that lead you to it.", "I must admit, that was quite a satisfying conclusion...", "Not often do I get to kill you by my own limbs.", "Though, the gourd was a bit strange, wasn't it...?" } },
	},
	["co-op"] = {
		{ weight = 6.00, lines = { "What on earth? There are more of you?", "This doesn't make any sense to me...", "I think I need to get my eyesight checked." } },
		{ weight = 6.00, lines = { "Ah, you brought backup this time...? How strange.", "Normally you're all alone. It's quite amusing.", "Ah, well. I'll admit defeat this time.", "Fair fights don't seem to be your thing, anyway..." } },
		{ weight = 6.00, lines = { "Something about this feels wrong. Very wrong.", "There are others like you? I thought the rest all were...", "There's some trickery at play. I know it.", "Your entire existence seems to go against the natural order..." } },
	},
	["newgameplus"] = {
		{ weight = 6.00, lines = { "Hello again. I feel a sense of deja vu.", "Surely this is your doing, yes?", "It's rather confusing. Almost like a proper reset, but...", "Everything is intensified. You, others, and the pain I feel...", "It's not worse, it's just... increased.", "My curiosity is fading. End this now." } },
		{ weight = 6.00, lines = { "Greetings. Again.", "I'm beginning to get a bit tired of speaking to you.", "It doesn't particularly help that you are incapable of speaking back.", "At least, in a way that I can understand...", "Let's just cut this short, this time." } },
	},
	["newgamealot"] = {
		{ weight = 12.0, lines = { "No more... No more, please.", "How much further do you plan to go?", "There is nothing to be gained here. Nothing but death.", "Or, is that what you seek? To make others suffer?", "You've achieved it, to say the least. Now, please...", "End this inane cycle." } },
		{ weight = 12.0, lines = { "You just... never stop, do you?", "It's beginning to be a bit frightening.", "What motivates you? Boredom? Blind curiosity?", "Surely, at this point, you've seen all there is to see.", "Why go beyond? Just to prove that you can?", "Trying to understand you is giving me a headache.", "I'd best not think about it much more." } },
	},
	["stevescott"] = {
		{ weight = 6.00, lines = { "...Why exactly is that temple guardian following you?", "I hope you don't plan on getting it involved in our fight.", "You already cause me enough grief when you're alone...", "Take care of it first, please, and then we can begin." } },
		{ weight = 6.00, lines = { "Hah! You look a bit overwhelmed there, little one.", "What did you do to get one of the Gods' guards sicced on you?", "They usually only get that mad if the holy temples are damaged...", "Worms? Spiders? Don't bother giving me excuses...", "I know exactly how sacreligious your actions can be." } },
	},
	["peaceful"] = {
		{ weight = 9999, lines = { "You've done it? You've done it.", "I never thought I'd see the day...", "Does this mean it's over? The loop is broken?", "You control the fate of this world, so...", "You can live here forever now. No one will harm you ever again.", "Thank you, player... Thank you. Truly." } },
		{ weight = 9999, lines = { "My mind feels so clear... What's going on?", "The Sampo... My life's work...", "The Gods were satisfied with it? I'm so glad...", "It seems that we ended up making a good team after all.", "So is this the end...? No more runs?", "I'm so accustomed to being hopeless, it's quite strange...", "To think that things may finally change." } },
	},
	["2orbs"] = {
		{ weight = 1.00, lines = { "Our knowledge... I believe I've learned something.", "Yes... The Sampo is stronger now. I'm sure of it.", "But it's still not enough, I believe...", "If your goal is to change fate, then I need to know more.", "If your goal is just to kill me... Then so be it." } },
	},
	["5orbs"] = {
		{ weight = 2.00, lines = { "Our knowledge... This is enough for something great.", "With these " .. orbs .. ", do you seek to delve deeper?", "I don't know what the best choice is here...", "Even with this knowledge, I still feel like I don't know anything.", "I leave the choice up to you, small one." } },
	},
	["11orbs"] = {
		{ weight = 4.00, lines = { "Our knowledge... This can make a difference.", "It's not much, but...", "It'll give us a happier ending than what we've had.", "That type of change is welcome, always." } },
	},
	["31orbs"] = {
		{ weight = 8.00, lines = { "Our knowledge... We're so close now.", "You've overcome the corruption and the shadows...", "Just a little bit more. Can you handle it?", "Or... do you wish to end this now?", "Do what you must." } },
	},
	["33orbs"] = {
		{ weight = 16.0, lines = { "Our knowledge... This is enough. You've done it.", "Take the Sampo in its true form. Please...", "Offer it to our Gods. They will know what to do." } },
	},
	["34orbs"] = {
		{ weight = 32.0, lines = { "Our knowledge... You've gone far beyond expectations.", "I won't pretend that I understand how you even did it...", "But, whatever. Go finish what you've started." } },
	},
	["gourd"] = {
		{ weight = 6.00, lines = { "What is that? ...Is that a gourd?", "Why do you have it? Shouldn't you use it for healing?", "You really are such a strange little creature...", "Kindly, keep it away from me. Please." } },
		{ weight = 6.00, lines = { "Fruit. You brought fruit...?", "Keep that away from me, please... I'm allergic.", "Where did you even get something like that?", "That type of fruit isn't native to... anywhere.", "How truly unusual..." } },
	}
}

---@return original_weighted_pair[]
local function GenerateValid()
	local reqs = ({
		["none"]         = true,
		["pacifist"]     = tonumber(StatsGetValue("enemies_killed")) <= 0,
		["damageless"]   = tonumber(StatsGetValue("damage_taken")) <= 0,
		["speedrun"]     = tonumber(StatsGetValue("playtime")) <= 480,
		["glasscannon"]  = GameHasFlagRun("PERK_PICKED_GLASS_CANNON"),
		["notinkering"]  = tonumber(StatsGetValue("wands_edited")) <= 0 or (GameHasFlagRun("PERK_PICKED_NO_WAND_EDITING") and not GameHasFlagRun("PERK_PICKED_EDIT_WANDS_ANYWHERE")),
		["wandcapacity"] = GameHasFlagRun("PERK_PICKED_GRAHAM_EXTRA_SLOTS") and not HasFlagPersistent("graham_used_unlock_all"),
		["co-op"]        = ModIsEnabled("SimpleCoop") or ModIsEnabled("CouchCoOp") or ModIsEnabled("noita-together") or ModIsEnabled("quant.ew") or ModIsEnabled("iota_multiplayer"),
		["newgameplus"]  = tonumber(SessionNumbersGetValue("NEW_GAME_PLUS_COUNT")) > 0,
		["newgamealot"]  = tonumber(SessionNumbersGetValue("NEW_GAME_PLUS_COUNT")) > 2,
		["stevescott"]   = #EntityGetInRadiusWithTag(x, y, 200, "necromancer_shop") > 0 and not GameHasFlagRun("PEACE_WITH_GODS"),
		["peaceful"]     = ComponentGetValue2(EntityGetFirstComponent(GameGetWorldStateEntity(), "WorldStateComponent") or 0, "ENDING_HAPPINESS"),
		["2orbs"]        = orbs >= 2 and orbs < 5,
		["5orbs"]        = orbs >= 5 and orbs < 11,
		["11orbs"]       = orbs >= 11 and orbs < 31,
		["31orbs"]       = orbs >= 31 and orbs < 33,
		["33orbs"]       = orbs == 33,
		["34orbs"]       = orbs >= 34,
		["gourd"]        = #EntityGetInRadiusWithTag(x, y, 300, "gourd") ~= 0,
	})
	---@type original_weighted_pair[]
	built = {}
	for k, v in pairs(reqs) do
		if v then
			for k2, v2 in ipairs(lines[k]) do
				table.insert(built, { original = k, offset = k2, weight = v2.weight })
			end
		end
	end
	-- dofile_once("mods/grahamsdialogue/files/lib/print.lua")
	-- print_any(built)
	return built
end

if choice == "error" or GameGetFrameNum() > frames + 36000 then -- choose new speech if one hasn't been chosen or if 10 minutes have passed
	local valid = GenerateValid()
	local ex = DiscreteIntegral(valid, function(v) return v.weight end, false)
	choice = ex.original
	offset = ex.offset
	GlobalsSetValue("GRAHAM_KOLMI_SPEECH", ex.original)
	GlobalsSetValue("GRAHAM_KOLMI_OFFSET", tostring(ex.offset))
	GlobalsSetValue("GRAHAM_KOLMI_FRAMES", tostring(GameGetFrameNum()))
	GlobalsSetValue("GRAHAM_KOLMI_PROGRESS", "1")
	choice = GlobalsGetValue("GRAHAM_KOLMI_SPEECH", "error")
	offset = tonumber(GlobalsGetValue("GRAHAM_KOLMI_OFFSET", "0"))
	frames = tonumber(GlobalsGetValue("GRAHAM_KOLMI_FRAMES", "0"))
	amount = tonumber(GlobalsGetValue("GRAHAM_KOLMI_PROGRESS", "1"))
end

local line = lines[choice][offset].lines[amount]
if line ~= nil and GameGetFrameNum() > frames + 120 then
	local returned = Speak(GetUpdatedEntityID(), line, pools.CUSTOM)
	if returned ~= nil then
		GlobalsSetValue("GRAHAM_KOLMI_PROGRESS", tostring(amount + 1))
		GlobalsSetValue("GRAHAM_KOLMI_FRAMES", tostring(GameGetFrameNum()))
	end
end
