--dofile("mods/grahamsdialogue/files/common.lua")
local me = GetUpdatedEntityID()
local x, y = EntityGetTransform(me)
SetRandomSeed(x + GameGetFrameNum(), y + 1394)
local rate = math.floor(tonumber(ModSettingGet("grahamsdialogue.idle")) + 0.5)
if ModSettingGet("grahamsdialogue.idle_enabled") == false then return end
if Random(1, rate) == 1 then
	dofile_once("mods/grahamsdialogue/files/common.lua")
	local worldstatecomp = EntityGetFirstComponent(GameGetWorldStateEntity(), "WorldStateComponent") or 0
	local inventory = EntityGetFirstComponent(me, "Inventory2Component") or 0
	local wand = ComponentGetValue2(inventory, "mActiveItem") or 0
	local random = Random(1, 10)
	-- this is a sort of priority system; hopefully this many elseifs won't cause problems
	if not (EntityHasTag(me, "no_generic_dialogue") or NameGet(me) == "$animal_playerghost") or IsBoss(me) then
		if EntityHasGameEffect(me, { "ON_FIRE" }) and not EntityHasGameEffect(me, { "PROTECTION_ALL", "PROTECTION_FIRE" }) then -- on fire
			Speak(me, GetLineGeneric(GENERIC_ONFIRE, "GENERIC_ONFIRE"), pools.GENERIC, true, true)
			return
		elseif random <= 5 and ComponentGetValue2(worldstatecomp, "ENDING_HAPPINESS") then -- peaceful ending
			Speak(me, GetLineGeneric(GENERIC_PEACEFULENDING, "GENERIC_PEACEFULENDING"), pools.GENERIC)
			return
		elseif random <= 6 and wand ~= 0 and EntityHasTag(wand, "wand") then -- holding wand
			Speak(me, GetLineGeneric(GENERIC_HOLDINGWAND, "GENERIC_HOLDINGWAND"), pools.GENERIC)
			return
		elseif random <= 4 and EntityHasGameEffect(me, { "DRUNK" }) then -- drunk (both ingestion and alcohol stain)
			Speak(me, GetLineGeneric(GENERIC_DRUNK, "GENERIC_DRUNK"), pools.GENERIC)
			return
		elseif random <= 7 and EntityHasGameEffect(me, { "BERSERK" }) then -- berserk
			Speak(me, GetLineGeneric(GENERIC_BERSERK, "GENERIC_BERSERK"), pools.GENERIC)
			return
		elseif random <= 9 and EntityHasGameEffect(me, { "CHARM" }) then -- charmed
			Speak(me, GetLineGeneric(GENERIC_CHARMED, "GENERIC_CHARMED"), pools.GENERIC)
			return
		elseif random <= 4 and EntityHasGameEffect(me, { "RADIOACTIVE" }) then -- toxic
			Speak(me, GetLineGeneric(GENERIC_TOXIC, "GENERIC_TOXIC"), pools.GENERIC)
			return
		end
	end

	local name = NameGet(me)
	for i = 1, #DIALOGUE_IDLE do
		if DIALOGUE_IDLE[i][1] == name then
			Speak(me, GetLine(DIALOGUE_IDLE, i, pools.IDLE), pools.IDLE)
			break
		end
	end
end
