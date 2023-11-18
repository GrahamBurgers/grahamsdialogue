local me = GetUpdatedEntityID()
local comp = EntityGetFirstComponent(me, "VariableStorageComponent", "graham_speech_removable")
if not comp then return end
if GameGetGameEffectCount(me, "FROZEN") > 0 or GameGetGameEffectCount(me, "ELECTROCUTION") > 0 then return end
local text = ComponentGetValue2(comp, "value_string")
local sprite = EntityGetFirstComponent(me, "SpriteComponent", "graham_speech_text") or 0
local amount = 1
local current = ComponentGetValue2(sprite, "text")
local slow = false
if string.len(current) ~= string.len(text) then
	if EntityHasTag(me, "robot") then
		amount = 3
		slow = true
	end
	if GameGetGameEffectCount(me, "MOVEMENT_FASTER_2X") > 0 then amount = amount * 2 end
	if GameGetGameEffectCount(me, "SLIMY") > 0 then slow = true end
	if slow and ComponentGetValue2(GetUpdatedComponentID(), "mTimesExecuted") % 3 ~= 0 then return end
	local new = string.sub(text, 1, string.len(current) + amount)
	local gui = GuiCreate()
	GuiStartFrame(gui)
	local width
	---@type string
	local font = ComponentGetValue2(sprite, "image_file") or 0
	if font ~= "mods/grahamsdialogue/files/font_data/font_pixel_white.xml" then
		local _, start = font:find("font_data/")
		local trimmed_font = font:sub((start or 0) + 1, font:find("%.") - 1)
		width = dofile("mods/grahamsdialogue/files/custom_font.lua")(trimmed_font, new)
	else
		width = GuiGetTextDimensions(gui, new, 1) / 2
	end
	GuiDestroy(gui)

	ComponentSetValue2(sprite, "text", new)
	ComponentSetValue2(sprite, "offset_x", width)
	EntityRefreshSprite(me, sprite)
end
local counter = ComponentGetValue2(comp, "value_int") + 1
ComponentSetValue2(comp, "value_int", counter)
if counter > string.len(text) + 180 then
	dofile_once("mods/grahamsdialogue/files/common.lua") -- hax?
	RemoveCurrentDialogue(GetUpdatedEntityID())
end
