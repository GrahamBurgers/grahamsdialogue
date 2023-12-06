dofile("mods/grahamsdialogue/files/common.lua")
local choice = tonumber(GlobalsGetValue( "GRAHAM_KOLMI_SPEECH", "0"))
local frames = tonumber(GlobalsGetValue( "GRAHAM_KOLMI_FRAMES", "0"))
local amount = tonumber(GlobalsGetValue( "GRAHAM_KOLMI_PROGRESS", "1"))

local lines = {
    {"none",         1.00,    {"test 1.1", "test 1.2", "test 1.3"} },
    {"none",         1.00,    {"test 2.1", "test 2.2", "test 2.3"} },
    {"none",         1.00,    {"test 3.1", "test 3.2", "test 3.3"} },
    {"pacifist",     50.0,    {"pacifist 1.1", "pacifist 1.2", "pacifist 1.3"} },
    {"pacifist",     50.0,    {"pacifist 2.1", "pacifist 2.2", "pacifist 2.3"} },
    {"damageless",   50.0,    {"damageless 1.1", "damageless 1.2", "damageless 1.3"} },
    {"damageless",   50.0,    {"damageless 2.1", "damageless 2.2", "damageless 2.3"} },
    {"speedrun",     9999,    {"speedrun 1.1", "speedrun 1.2", "speedrun 1.3"} },
    {"speedrun",     1.00,    {"speedrun 2.1", "speedrun 2.2", "speedrun 2.3"} },
}

if choice == 0 or GameGetFrameNum() > frames + 36000 then -- choose new speech if one hasn't been chosen or if 10 minutes have passed
    local choosable = {}
    local reqs = ({
        ["none"]           = true,
        ["pacifist"]       = tonumber( StatsGetValue("enemies_killed") ) <= 0,
        ["damageless"]     = tonumber( StatsGetValue("damage_taken") ) <= 0,
        ["speedrun"]       = tonumber( StatsGetValue("playtime") ) <= 480,
    })
    for i = 1, #lines do
        if reqs[lines[i][1]] then
            print(lines[i][1] .. " yes")
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
    if line ~= nil then
        local returned = Speak(GetUpdatedEntityID(), line, pools.CUSTOM)
        if returned ~= nil then
            GlobalsSetValue( "GRAHAM_KOLMI_PROGRESS", tostring(amount + 1))
            GlobalsSetValue( "GRAHAM_KOLMI_FRAMES", tostring(GameGetFrameNum()))
        end
    end
end