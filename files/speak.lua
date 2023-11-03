local me = GetUpdatedEntityID()
local comp = EntityGetFirstComponent(me, "VariableStorageComponent", "graham_speech_removable")
if not comp then return end
local text = ComponentGetValue2(comp, "value_string")
local sprites = EntityGetComponent(me, "SpriteComponent", "graham_speech_text") or {}
for i = 1, #sprites do
    local current = ComponentGetValue2(sprites[i], "text")
    local new = string.sub(text, 1, string.len(current) + 1)
    local gui = GuiCreate()
    GuiStartFrame(gui)
    local width = GuiGetTextDimensions( gui, new, 1 ) / 2
    GuiDestroy(gui)

    ComponentSetValue2(sprites[i], "text", new)
    ComponentSetValue2(sprites[i], "offset_x", width)
    EntityRefreshSprite(me, sprites[i])
end