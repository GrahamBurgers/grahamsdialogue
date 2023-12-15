dofile_once("mods/grahamsdialogue/files/common.lua")
dofile_once("mods/grahamsdialogue/files/types.lua")

---@type string
local phase = GlobalsGetValue("grahamsdialogue_kolmi_phase", "none")
---@type table<string,kolmi_pair>
local phase_lines = { -- weight is 0..1
	firepillar        = {lines = { "This should prove to be quite scalding...", "I'm reaching my boiling point with you...!" }, weight = 0.4},
	circleshot        = {lines = { "Don't get dizzy... This one might hurt.", "Here's something basic. Dodge it, or else..." }, weight = 0.5},
	chase             = {lines = { "Don't you dare run away from this fight!", "I'm not done with you yet! Get back here!" }, weight = 0.8},
	slow_chase        = {lines = { "No way out now. Fight like it means the world.", "Get over here. I've got a surprise..." }, weight = 0.8},
	chase_direct      = {lines = { "I'm not letting you go!", "Oh, no, you don't!" }, weight = 1.0},
	spawn_minion      = {lines = { "Helpers, go! Give 'em hell!", "Onward, minions! Fight for me..." }, weight = 0.6},
	explosion         = {lines = { "Boom! Take that!", "Shower the arena in sparks!" }, weight = 1.0},
	homingshot        = {lines = { "Slime is extremely conductive... Keep your distance!", "Bugs can be quite shocking, I've heard..." }, weight = 1.0},
	polymorph         = {lines = { "Did you bring polymorph immunity? What a shame...", "If I were you... I'd not want this one to hit." }, weight = 1.0},
	melee             = {lines = { "Die already! Just die!", "You're... Such a frustrating creature!" }, weight = 1.0},
	clean_materials   = {lines = { "Got to keep this place clean...", "Ah, what a mess we've made..." }, weight = 0.6},
	aggro             = {lines = { "Cut it out! I'm so tired of you...", "This has gone on for far too long!" }, weight = 1.0},
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
