dofile_once("mods/grahamsdialogue/files/common.lua")
local choice = tonumber(GlobalsGetValue( "GRAHAM_KOLMI_SPEECH", "0"))
local frames = tonumber(GlobalsGetValue( "GRAHAM_KOLMI_FRAMES", "0"))
local amount = tonumber(GlobalsGetValue( "GRAHAM_KOLMI_PROGRESS", "1"))

---@class weighted_line
---@field weight number
---@field lines string[]


local lines = {
    {"none",           0.30,    {"", "", ""} },
    {"none",           0.30,    {"", "", ""} },
    {"none",           0.30,    {"", "", ""} },
    {"none",           0.30,    {"", "", ""} },
    {"none",           0.30,    {"", "", ""} },
    {"pacifist",       3.00,    {"You've changed your ways. How interesting.", "Relentless killing, replaced by pacifism...", "Oh, but it's the same person beneath, isn't it?", "The others don't see it, but I do. It's clear as crystal.", "You're corrupt inside. Malicious. Irreversably so.", "How ironic indeed."} },
    {"pacifist",       3.00,    {"Interesting. How very implausible...", "You've managed to subdue your murderous tendencies.", "For one simple run, at the very least...", "My apologies. I can hold a bit of a grudge.", "I'm sure you've already forgotten the many deaths you've given me..."} },
    {"pacifist",       3.00,    {"Hmm. This feels a bit futile, doesn't it?", "No matter what, our deaths mark the end of this world...", "Sparing the lives of a few creatures won't change that.", "Though I appreciate the gesture... I distrust your intentions.", "Would you reall ever think of others before yourself?"} },
    {"pacifist",       3.00,    {"", "", ""} },
    {"pacifist",       3.00,    {"", "", ""} },
    {"damageless",     6.00,    {"Hah. You amuse me, familiar one.", "Not a single point of damage taken? Impressive.", "Let's see if I can't change that for you, eh?", "It's only fair, after the countless deaths you've given me..."} },
    {"damageless",     6.00,    {"", "", ""}},
    {"damageless",     6.00,    {"", "", ""}},
    {"damageless",     6.00,    {"", "", ""}},
    {"damageless",     6.00,    {"", "", ""}},
    {"speedrun",       2.00,    {"Ah. You arrived here... Sooner than I expected.", "Oh, but don't let me slow you down, little one.", "I'll let you win, and then you can be on your way...", "Just kidding. I'm not going to hold back.", "Your little speedrun means nothing to me."} },
    {"speedrun",       3.00,    {"Curious. You're... Rather quick, aren't you?", "Well, don't bother listening to my ramblings, eh?", "I already know what you're here for.", "Let's just make this quick."} },
    {"speedrun",       1.00,    {"I think I understand you a bit better, now.", "You enjoy a challenge, yes? Something to keep you busy...", "I cannot guarantee that I'll be what you desire, but...", "If this is what it takes... Then I shall fight."} },
    {"speedrun",       1.00,    {"Hello there. I think you're here early.", "Not that I'm one to complain. It's all the same to me.", "Although I'd appreciate it if you let me finish my work for once...", "Ah, well. I'm ready when you are."} },
    {"speedrun",       1.00,    {"You think you're fast? I've seen better.", "And once I end your life... Heheh.", "This whole run will have been a waste of time."} },
    {"notinkering",    2.00,    {"Eh? No tinkering? That's rather odd.", "Such magic at your disposal, and you reject it...", "Well. I suppose I shan't complain.", "It makes your death more likely, to say the least.", "That is something I will always welcome."} },
    {"notinkering",    1.00,    {"Hello there. What are you doing this time?", "I thought wands were... Quite important to you.", "To lose the ability to edit them must be tough.", "Oh, no. Do not mistake my curiosity for empathy.", "I will end you all the same."} },
    {"notinkering",    1.00,    {"", "", ""} },
    {"glasscannon",    1.00,    {"", "", ""} },
    {"glasscannon",    1.00,    {"", "", ""} },
    {"glasscannon",    1.00,    {"", "", ""} },
    {"wandcapacity",   12.0,    {"Heheh... That perk that you have there... I recognize it.", "\"Wand Capacity +\". I remember the path that lead you to it.", "I must admit, that was quite a satisfying conclusion...", "Not often do I get to kill you by my own limbs.", "Though, the gourd was a bit strange, wasn't it...?"} },
    {"co-op",          6.00,    {"What on earth? There are more of you?", "This doesn't make any sense to me...", "I think I need to get my eyesight checked."} },
    {"co-op",          6.00,    {"Ah, you brought backup this time...? How strange.", "Normally you're all alone. It's quite amusing.", "Ah, well. I'll admit defeat this time.", "Fair fights don't seem to be your thing, anyway..."} },
    {"co-op",          6.00,    {"Something about this feels wrong. Very wrong.", "There are others like you? I thought the rest all were...", "There's some trickery at play. I know it.", "Your entire existence seems to go against the natural order..."} },
    {"newgameplus",    6.00,    {"", "", ""} },
    {"newgameplus",    6.00,    {"", "", ""} },
    {"newgameplus",    6.00,    {"", "", ""} },
    {"newgamealot",    12.0,    {"", "", ""} },
    {"newgamealot",    12.0,    {"", "", ""} },
    {"newgamealot",    12.0,    {"", "", ""} },
}

if choice == 0 or GameGetFrameNum() > frames + 36000 then -- choose new speech if one hasn't been chosen or if 10 minutes have passed
    local choosable = {}
    local reqs = ({
        ["none"]           = true,
        ["pacifist"]       = tonumber( StatsGetValue("enemies_killed") ) <= 0,
        ["damageless"]     = tonumber( StatsGetValue("damage_taken") ) <= 0,
        ["speedrun"]       = tonumber( StatsGetValue("playtime") ) <= 480,
        ["glasscannon"]    = GameHasFlagRun("PERK_PICKED_GLASS_CANNON"),
        ["notinkering"]    = tonumber( StatsGetValue("wands_edited" ) ) <= 0 or (GameHasFlagRun("PERK_PICKED_NO_WAND_EDITING") and not GameHasFlagRun("PERK_PICKED_EDIT_WANDS_ANYWHERE")),
        ["wandcapacity"]   = GameHasFlagRun("PERK_PICKED_GRAHAM_EXTRA_SLOTS") and not HasFlagPersistent("graham_used_unlock_all"),
        ["co-op"]          = ModIsEnabled("SimpleCoop") or ModIsEnabled("CouchCoOp") or ModIsEnabled("noita-together"),
        ["newgameplus"]    = tonumber( SessionNumbersGetValue( "NEW_GAME_PLUS_COUNT" )) > 0,
        ["newgamealot"]    = tonumber( SessionNumbersGetValue( "NEW_GAME_PLUS_COUNT" )) > 3,
    })
    for i = 1, #lines do
        if reqs[lines[i][1]] then
            choosable[#choosable+1] = i
        end
    end
    choice = Random(1, #choosable)
    -- NATHAN PUT YOUR RANDOM CODE HERE ^^^
    GlobalsSetValue( "GRAHAM_KOLMI_SPEECH", tostring(choice))
    GlobalsSetValue( "GRAHAM_KOLMI_FRAMES", tostring(GameGetFrameNum()))
    GlobalsSetValue( "GRAHAM_KOLMI_PROGRESS", "1")
end
if choice ~= 0 then
    local line = lines[choice][3][amount]
    if line ~= nil and GameGetFrameNum() > frames + 120 then
        local returned = Speak(GetUpdatedEntityID(), line, pools.CUSTOM)
        if returned ~= nil then
            GlobalsSetValue( "GRAHAM_KOLMI_PROGRESS", tostring(amount + 1))
            GlobalsSetValue( "GRAHAM_KOLMI_FRAMES", tostring(GameGetFrameNum()))
        end
    end
end