dofile_once("mods/grahamsdialogue/files/common.lua")
dofile_once("mods/grahamsdialogue/files/types.lua")

---@type string
local phase = GlobalsGetValue("grahamsdialogue_kolmi_phase", "none")
local phase_lines = {
	firepillarr = { "Grr so fire!" },
	circleshot = { "Circles!!!" },
	chase = { "I am running...." },
	slow_chase = { "speakers", "write these grahams" },
	chase_direct = { "speakers", "write these grahams" },
	spawn_minion = { "speakers", "write these grahams" },
	firepillar = { "speakers", "write these grahams" },
	explosion = { "speakers", "write these grahams" },
	homingshot = { "speakers", "write these grahams" },
	polymorph = { "speakers", "write these grahams" },
	melee = { "speakers", "write these grahams" },
	clean_materials = { "speakers", "write these grahams" },
	aggro = { "speakers", "write these grahams" },
}
if phase == "none" then return end
local kolmi = GetUpdatedEntityID()
local line
local phase_comment_probability = 0.3

if math.random() < phase_comment_probability then
	---@diagnostic disable-next-line: param-type-mismatch
	line = GetLineGeneric(phase_lines[phase] or { "i have no lines for " .. phase }, "kolmi")
end

Speak(kolmi, line, pools.CUSTOM)
