local me = GetUpdatedEntityID()
local x, y = EntityGetTransform(me)
SetRandomSeed(x + GameGetFrameNum(), y + 1394)
local rate = math.floor(tonumber(ModSettingGet("grahamsdialogue.idle")) + 0.5)
if ModSettingGet("grahamsdialogue.idle_enabled") == false then return end
if Random(1, rate) == 1 then
    dofile_once("mods/grahamsdialogue/files/common.lua")
    local id = ComponentGetValue2(GetUpdatedComponentID(), "script_polymorphing_to") -- I don't feel like using a VariableStorageComponent
    for i = 1, #Custom_speak_lines do
        if Custom_speak_lines[i][1] == id then
            local type = Random(2, #Custom_speak_lines[i])
            Speak(me, Custom_speak_lines[i][type], "CUSTOM", true, false, id)
            break
        end
    end
end