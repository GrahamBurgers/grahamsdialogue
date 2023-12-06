dofile_once("mods/grahamsdialogue/files/common.lua")
dofile_once("mods/grahamsdialogue/files/types.lua")
local choice = GlobalsGetValue("GRAHAM_KOLMI_SPEECH", "error")
local offset = tonumber(GlobalsGetValue("GRAHAM_KOLMI_OFFSET", "0"))
local frames = tonumber(GlobalsGetValue("GRAHAM_KOLMI_FRAMES", "0"))
local amount = tonumber(GlobalsGetValue("GRAHAM_KOLMI_PROGRESS", "1"))

---@type line_pool
local lines = {
	["none"] = {
		{ weight = 0.30, lines = { "", "", "" } },
		{ weight = 0.30, lines = { "", "", "" } },
		{ weight = 0.30, lines = { "", "", "" } },
		{ weight = 0.30, lines = { "", "", "" } },
		{ weight = 0.30, lines = { "", "", "" } },
	},
	["pacifist"] = {
		{ weight = 3.00, lines = { "You've changed your ways. How interesting.", "Relentless killing, replaced by pacifism...", "Oh, but it's the same person beneath, isn't it?", "The others don't see it, but I do. It's clear as crystal.", "You're corrupt inside. Malicious. Irreversably so.", "How ironic indeed." } },
		{ weight = 3.00, lines = { "Interesting. How very implausible...", "You've managed to subdue your murderous tendencies.", "For one simple run, at the very least...", "My apologies. I can hold a bit of a grudge.", "I'm sure you've already forgotten the many deaths you've given me..." } },
		{ weight = 3.00, lines = { "Hmm. This feels a bit futile, doesn't it?", "No matter what, our deaths mark the end of this world...", "Sparing the lives of a few creatures won't change that.", "Though I appreciate the gesture... I distrust your intentions.", "Would you reall ever think of others before yourself?" } },
		{ weight = 3.00, lines = { "", "", "" } },
		{ weight = 3.00, lines = { "", "", "" } },
	},
	["damageless"] = {
		{ weight = 6.00, lines = { "Hah. You amuse me, familiar one.", "Not a single point of damage taken? Impressive.", "Let's see if I can't change that for you, eh?", "It's only fair, after the countless deaths you've given me..." } },
		{ weight = 6.00, lines = { "", "", "" } },
		{ weight = 6.00, lines = { "", "", "" } },
		{ weight = 6.00, lines = { "", "", "" } },
		{ weight = 6.00, lines = { "", "", "" } },
	},
	["speedrun"] = {
		{ weight = 2.00, lines = { "Ah. You arrived here... Sooner than I expected.", "Oh, but don't let me slow you down, little one.", "I'll let you win, and then you can be on your way...", "Just kidding. I'm not going to hold back.", "Your little speedrun means nothing to me." } },
		{ weight = 3.00, lines = { "Curious. You're... Rather quick, aren't you?", "Well, don't bother listening to my ramblings, eh?", "I already know what you're here for.", "Let's just make this quick." } },
		{ weight = 1.00, lines = { "I think I understand you a bit better, now.", "You enjoy a challenge, yes? Something to keep you busy...", "I cannot guarantee that I'll be what you desire, but...", "If this is what it takes... Then I shall fight." } },
		{ weight = 1.00, lines = { "Hello there. I think you're here early.", "Not that I'm one to complain. It's all the same to me.", "Although I'd appreciate it if you let me finish my work for once...", "Ah, well. I'm ready when you are." } },
		{ weight = 1.00, lines = { "You think you're fast? I've seen better.", "And once I end your life... Heheh.", "This whole run will have been a waste of time." } },
	},
	["notinkering"] = {
		{ weight = 2.00, lines = { "Eh? No tinkering? That's rather odd.", "Such magic at your disposal, and you reject it...", "Well. I suppose I shan't complain.", "It makes your death more likely, to say the least.", "That is something I will always welcome." } },
		{ weight = 1.00, lines = { "Hello there. What are you doing this time?", "I thought wands were... Quite important to you.", "To lose the ability to edit them must be tough.", "Oh, no. Do not mistake my curiosity for empathy.", "I will end you all the same." } },
		{ weight = 1.00, lines = { "", "", "" } },
	},
	["glasscannon"] = {
		{ weight = 1.00, lines = { "", "", "" } },
		{ weight = 1.00, lines = { "", "", "" } },
		{ weight = 1.00, lines = { "", "", "" } },
	},
	["wandcapacity"] = {
		{ weight = 12.0, lines = { "Heheh... That perk that you have there... I recognize it.", "\"Wand Capacity +\". I remember the path that lead you to it.", "I must admit, that was quite a satisfying conclusion...", "Not often do I get to kill you by my own limbs.", "Though, the gourd was a bit strange, wasn't it...?" } },
	},
	["co-op"] = {
		{ weight = 6.00, lines = { "What on earth? There are more of you?", "This doesn't make any sense to me...", "I think I need to get my eyesight checked." } },
		{ weight = 6.00, lines = { "Ah, you brought backup this time...? How strange.", "Normally you're all alone. It's quite amusing.", "Ah, well. I'll admit defeat this time.", "Fair fights don't seem to be your thing, anyway..." } },
		{ weight = 6.00, lines = { "Something about this feels wrong. Very wrong.", "There are others like you? I thought the rest all were...", "There's some trickery at play. I know it.", "Your entire existence seems to go against the natural order..." } },
	},
	["newgameplus"] = {
		{ weight = 6.00, lines = { "", "", "" } },
		{ weight = 6.00, lines = { "", "", "" } },
		{ weight = 6.00, lines = { "", "", "" } },
	},
	["newgamealot"] = {
		{ weight = 12.0, lines = { "", "", "" } },
		{ weight = 12.0, lines = { "", "", "" } },
	},
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
		["co-op"]        = ModIsEnabled("SimpleCoop") or ModIsEnabled("CouchCoOp") or ModIsEnabled("noita-together"),
		["newgameplus"]  = tonumber(SessionNumbersGetValue("NEW_GAME_PLUS_COUNT")) > 0,
		["newgamealot"]  = tonumber(SessionNumbersGetValue("NEW_GAME_PLUS_COUNT")) > 3,
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
	return built
end

if choice == "error" or GameGetFrameNum() > frames + 36000 then -- choose new speech if one hasn't been chosen or if 10 minutes have passed
	local valid = GenerateValid()
	local sum = 0
	local integrated = {}
	for k, v in ipairs(valid) do
		sum = sum + v.weight
		table.insert(integrated, sum)
	end
	SetRandomSeed(182342,47729) -- some random coords, this way if you get a cool dialogue it'll be the same on the seed if you get same achievements.
	cutoff = Randomf(0.0, sum)
	local result = 1
	for k, v in ipairs(integrated) do
		if v <= cutoff then
			result = k
			break
		end
	end
	-- NATHAN PUT YOUR RANDOM CODE HERE ^^^
	choice = valid[result].original
	offset = valid[result].offset
	GlobalsSetValue("GRAHAM_KOLMI_SPEECH", valid[result].original)
	GlobalsSetValue("GRAHAM_KOLMI_OFFSET", tostring(valid[result].offset))
	GlobalsSetValue("GRAHAM_KOLMI_FRAMES", tostring(GameGetFrameNum()))
	GlobalsSetValue("GRAHAM_KOLMI_PROGRESS", "1")
end

local line = lines[choice][offset].lines[amount]
if line ~= nil and GameGetFrameNum() > frames + 120 then
	local returned = Speak(GetUpdatedEntityID(), line, pools.CUSTOM)
	if returned ~= nil then
		GlobalsSetValue("GRAHAM_KOLMI_PROGRESS", tostring(amount + 1))
		GlobalsSetValue("GRAHAM_KOLMI_FRAMES", tostring(GameGetFrameNum()))
	end
end
