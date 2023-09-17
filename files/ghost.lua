local textComponent = EntityGetFirstComponentIncludingDisabled(GetUpdatedEntityID(), "SpriteComponent", "graham_speech_text")
if textComponent then
    local comp = GetUpdatedComponentID()
    local amount = math.sin(0 - ComponentGetValue2(comp, "mTimesExecuted") / 7) / 25
    ComponentSetValue2(textComponent, "alpha", ComponentGetValue(textComponent, "alpha") + amount)
end