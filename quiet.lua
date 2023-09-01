local textComponent = EntityGetFirstComponentIncludingDisabled(GetUpdatedEntityID(), "SpriteComponent", "graham_speech_text")
if textComponent then EntityRemoveComponent(GetUpdatedEntityID(), textComponent)
EntityRemoveTag(GetUpdatedEntityID(), "graham_speaking") end