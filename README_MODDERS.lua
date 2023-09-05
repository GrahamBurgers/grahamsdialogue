---@diagnostic disable: undefined-global, lowercase-global

-- Do you have a mod that adds enemies to Noita? Statistically, you don't,
-- but if you do, then here's how to add custom dialogue to your enemies!
-- First, the basics; stick this code in your init.lua and swap out the names, you probably know how this all works
ModLuaFileAppend("mods/grahamsdialogue/common.lua", "YOURMOD/WHATEVERPATHYOUWANT/dialogue.lua")

-- !!! ALL THE CODE BELOW SHOULD GO IN dialogue.lua (or whatever you choose to name it) !!!


-- TO ADD REGULAR DIALOGUE: use the AddEnemyDialogue(str, str, table) function
-- This should work with both vanilla and modded enemies. If the enemy has no dialogue already
-- Use "DAMAGETAKEN" or "DAMAGEDEALT" or "IDLE" for the first parameter
AddEnemyDialogue("DAMAGETAKEN", "$name_of_enemy", {"Dialogue 1", "Dialogue 2", "Dialogue 3"})
-- If your enemy is not tagged with 'hittable' or 'graham_enemydialogue', then it will not be able to speak IDLE or DAMAGETAKEN lines.

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

-- Hopefully this will all work properly. I'm not very good at this
-- Enjoy!