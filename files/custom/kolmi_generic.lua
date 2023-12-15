dofile_once("mods/grahamsdialogue/files/common.lua")
dofile_once("mods/grahamsdialogue/files/types.lua")

---@type string
local phase = GlobalsGetValue("grahamsdialogue_kolmi_phase", "none")
local phase_lines = {
	firepillarr = { "Grr so fire!" },
	circleshot = { "Circles!!!" },
	chase = { "I am running...." },
}
if phase == "none" then return end
local kolmi = GetUpdatedEntityID()
local line
local phase_comment_probability = 0.3

if math.random() < phase_comment_probability then
	---@diagnostic disable-next-line: param-type-mismatch
	line = GetLineGeneric(phase_lines[phase] or {"i have no lines for " ..phase}, "kolmi")
end

Speak(kolmi, line, pools.CUSTOM, false) -- this is probably not how to use the api but idk i forgor.
