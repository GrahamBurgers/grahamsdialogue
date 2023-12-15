dofile_once("mods/grahamsdialogue/files/common.lua")
dofile_once("mods/grahamsdialogue/files/types.lua")

---@type string
local phase = GlobalsGetValue("grahamsdialogue_kolmi_phase", "none")
---@type table<string,kolmi_pair>
local phase_lines = { -- weight is 0..1
	firepillar = {lines = { "Grr so fire!" }, weight = 1.0},
	circleshot = {lines = { "Circles!!!" }, weight = 1.0},
	chase = {lines = { "I am running...." }, weight = 1.0},
	slow_chase = {lines = { "speakers", "write these grahams" }, weight = 1.0},
	chase_direct = {lines = { "speakers", "write these grahams" }, weight = 1.0},
	spawn_minion = {lines = { "speakers", "write these grahams" }, weight = 1.0},
	explosion = {lines = { "speakers", "write these grahams" }, weight = 1.0},
	homingshot = {lines = { "speakers", "write these grahams" }, weight = 1.0},
	polymorph = {lines = { "speakers", "write these grahams" }, weight = 1.0},
	melee = {lines = { "speakers", "write these grahams" }, weight = 1.0},
	clean_materials = {lines = { "speakers", "write these grahams" }, weight = 1.0},
	aggro = {lines = { "speakers", "write these grahams" }, weight = 1.0},
}
if phase == "none" then return end
local kolmi = GetUpdatedEntityID()
local line
local rate = math.floor(tonumber(ModSettingGet("grahamsdialogue.idle")) + 0.5)
-- print(tostring(rate))
-- print(tostring(math.random(rate)))
-- kolmi dialogue is not really kinda maybe a little bit idle but i will not turn it off because i do not respect the users opinions.
-- overruled.
if ModSettingGet("grahamsdialogue.idle_enabled") == false then return end
if  math.random() < (1 / rate) * phase_lines[phase].weight then
	---@diagnostic disable-next-line: param-type-mismatch
	line = GetLineGeneric(phase_lines[phase].lines or { "i have no lines for " .. phase }, "kolmi")
end

Speak(kolmi, line, pools.CUSTOM)
