local textComponent = EntityGetFirstComponentIncludingDisabled(GetUpdatedEntityID(), "SpriteComponent", "graham_speech_text")
if textComponent then EntityRemoveComponent(GetUpdatedEntityID(), textComponent)
EntityRemoveTag(GetUpdatedEntityID(), "graham_speaking") end
local ghostComponent = EntityGetFirstComponentIncludingDisabled(GetUpdatedEntityID(), "LuaComponent", "graham_speech_ghost")
if ghostComponent then EntityRemoveComponent(GetUpdatedEntityID(), ghostComponent) end