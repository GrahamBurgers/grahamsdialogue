SetRandomSeed(GameGetFrameNum() + GetUpdatedComponentID(), GetUpdatedEntityID() + 32490)
if Random(1, 5) == 1 then
    dofile_once("mods/grahamsdialogue/files/common.lua")
    Speak(GetUpdatedEntityID(), "PANIC!", pools.CUSTOM, false, false)
end