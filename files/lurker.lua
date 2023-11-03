local entity = GetUpdatedEntityID()
local visible = EntityGetFirstComponent(entity, "SpriteComponent") == EntityGetFirstComponentIncludingDisabled(entity, "SpriteComponent")

local texts = EntityGetComponentIncludingDisabled(entity, "SpriteComponent", "graham_speech_text") or {}
for i = 1, #texts do
    ComponentSetValue2(texts[i], "visible", visible)
end