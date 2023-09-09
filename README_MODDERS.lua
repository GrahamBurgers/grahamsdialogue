---@diagnostic disable: undefined-global, lowercase-global

-- Do you have a mod that adds enemies to Noita? Statistically, you don't,
-- but if you do, then here's how to add custom dialogue to your enemies!
-- First, the basics; stick this code in your init.lua and swap out the names, you probably know how this all works
ModLuaFileAppend("mods/grahamsdialogue/common.lua", "YOURMOD/WHATEVERPATHYOUWANT/dialogue.lua")

-- !!! ALL THE CODE BELOW SHOULD GO IN dialogue.lua (or whatever you choose to name it) !!!


-- TO ADD REGULAR DIALOGUE: use the AddEnemyDialogue(pool, name, dialogue) function
-- This should work with both vanilla and modded enemies. If the enemy has no dialogue already
-- Use "DAMAGETAKEN" or "DAMAGEDEALT" or "IDLE" for the pool parameter
AddEnemyDialogue("DAMAGETAKEN", "$name_of_enemy", {"Dialogue 1", "Dialogue 2", "Dialogue 3"})
-- If your enemy is not tagged with 'hittable' or 'graham_enemydialogue', then it will not be able to speak IDLE or DAMAGETAKEN lines.
-- NOTE: Enemies that are not tagged with 'graham_enemydialogue' WILL NOT speak if they do not have any custom dialogue in any pools.

-- Use EmptyEnemyDialogue(pool, name) to remove all of an enemy's currently-existing dialogue lines. Same parameters as above, except for the dialogue table.
EmptyEnemyDialogue("IDLE", "$name_of_enemy")

-- Use EnemyHasDialogue(pool, name) to detect if an enemy has dialogue in a specific pool, or use "ANY" for any pool.
EnemyHasDialogue("DAMAGEDEALT", "$name_of_enemy")

-- You can also append to the 'generic' dialogue pools; these will apply to any enemy under specific circumstances
-- GENERIC_HOLDINGWAND, GENERIC_CHARMED, GENERIC_ONFIRE, GENERIC_PEACEFULENDING, GENERIC_DRUNK, GENERIC_BERSERK, GENERIC_TOXIC, GENERIC_CONFUSED, GENERIC_HEALED
-- There's no limit to how many items these tables have. Just try to keep it immersive, eh?
-- Add the no_generic_dialogue tag to your enemy to make them exempt from generic lines of dialogue
table.insert(GENERIC_ONFIRE, "On Fire Dialogue")

-- Define a new value in special_offsets_x or special_offsets_y if you want your enemy's dialogue to be offset horizontally or vertically.
special_offsets_x["$name_of_your_enemy"] = 20
special_offsets_y["$name_of_your_enemy"] = 12

-- If you have multiple translation names for the same enemy, or different enemies who you want to have identical functionality, do this
DUPES["$name_of_your_enemy"] = "$name_of_mimic_enemy"

-- For other special functionality, like text size or other stuff, do this
local MakeSureThisIsNamedSomethingUnique = ModdedStuff
function ModdedStuff()
    MakeSureThisIsNamedSomethingUnique() -- make sure to call this function, otherwise you'll overwrite stuff that other mods do
    -- Your code goes here; make this whatever you want - typically, you'd want to modify variables like size_x or size_y
    if name == "$name_of_your_enemy" then
        size_x = size_x + 3
    end
end

-- And, finally, if you want an enemy to speak dialogue from any script, do it like this
if ModIsEnabled("grahamsdialogue") then
    dofile_once("mods/grahamsdialogue/common.lua")
    Speak(entity_id, "Dialogue to speak")
end

--[[
Hopefully this will all work properly. I'm not very good at this.
And never be afraid to ask me in my Discord server if you have questions or need help with something: https://discord.gg/DY6CVE2ua9
One more thing: (this part is completely optional):

STYLE GUIDES

Hiisi: Somewhat comical. Fighting is just their day job, but they still enjoy doing it. They speak like normal people, for the most part.
Robots: They usually never use contractions, sans very common ones like "I'm". They speak as if they were a text log in a computer, or an AI.
Fungi: The weaker ones can hardly form full sentences. They know more than they let on, but can't seem to find a way to say it.
Ghosts: They speak with a sense of longing, though they don't seem to consider a time in which they were alive. They don't see death as significant.
Spiders: ???
Worms: ???
Hell enemies: ???

]]--