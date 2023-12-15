dofile("data/scripts/lib/mod_settings.lua")

function mod_setting_change_callback( mod_id, gui, in_main_menu, setting, old_value, new_value  )
	print( tostring(new_value) )
end

local mod_id = "grahamsdialogue" -- This should match the name of your mod's folder.
mod_settings_version = 1 -- This is a magic global that can be used to migrate settings to new mod versions. call mod_settings_get_version() before mod_settings_update() to get the old value. 
mod_settings = 
{
	{
		id = "_",
		ui_name = "Right click any value to reset it to its default.",
		not_setting = true,
	},
	{
		id = "type",
		ui_name = "Display type",
		ui_description = "How should dialogue display when an enemy speaks?",
		value_default = "letter",
		values = { {"letter","One letter at a time"}, {"full","All at once"}},
		scope = MOD_SETTING_SCOPE_RUNTIME,
	},
	{
		id = "idle_enabled",
		ui_name = "Idling dialogue",
		ui_description = "Whether or not enemies can speak while idling.",
		value_default = true,
		scope = MOD_SETTING_SCOPE_RUNTIME,
	},
	{
		id = "idle",
		ui_name = "Idling dialogue chance",
		ui_description = "The chance for an enemy to speak when idling (every half second).",
		value_default = 50,
		value_min = 1,
		value_max = 200,
		value_display_formatting = " 1 in $0",
		scope = MOD_SETTING_SCOPE_RUNTIME,
	},
	{
		id = "damaged_enabled",
		ui_name = "Damaged dialogue",
		ui_description = "Whether or not enemies can speak when you damage them.",
		value_default = true,
		scope = MOD_SETTING_SCOPE_RUNTIME,
	},
	{
		id = "damaged",
		ui_name = "Damaged dialogue chance",
		ui_description = "The chance for an enemy to speak when you damage them.",
		value_default = 20,
		value_min = 1,
		value_max = 100,
		value_display_formatting = " 1 in $0",
		scope = MOD_SETTING_SCOPE_RUNTIME,
	},
	{
		id = "damaging_enabled",
		ui_name = "Damaging dialogue",
		ui_description = "Whether or not enemies can speak when damaging you.",
		value_default = true,
		scope = MOD_SETTING_SCOPE_RUNTIME,
	},
	{
		id = "damaging",
		ui_name = "Damaging dialogue chance",
		ui_description = "The chance for an enemy to speak when damaging you.",
		value_default = 5,
		value_min = 1,
		value_max = 20,
		value_display_formatting = " 1 in $0",
		scope = MOD_SETTING_SCOPE_RUNTIME,
	},
	--[[
	{
		id = "length",
		ui_name = "Dialogue duration",
		ui_description = "How long dialogue displays for, after an enemy is done speaking.\nNote that an enemy can't say a new line while they're already speaking one.",
		value_default = 120,
		value_min = 60,
		value_max = 360,
		value_display_formatting = " $0 frames",
		scope = MOD_SETTING_SCOPE_RUNTIME,
	},
	]]--
	{
		id = "transparency",
		ui_name = "Dialogue transparency",
		ui_description = "How see-through the dialogue text is.",
		value_default = 20,
		value_min = 0,
		value_max = 90,
		value_display_formatting = " $0%",
		scope = MOD_SETTING_SCOPE_RUNTIME,
	},
	{
		id = "scale",
		ui_name = "Dialogue scale",
		ui_description = "How large the dialogue is.\nMay cause strange offset scenarios if changed.",
		value_default = 1,
		value_min = 0.75,
		value_max = 1.25,
		value_display_multiplier = 100,
		value_display_formatting = " $0%",
		scope = MOD_SETTING_SCOPE_RUNTIME,
	},
	--[[
	{
		id = "unique",
		ui_name = "Uniqueness factor",
		ui_description = "How much the enemies try to have unique lines.\n0% means not at all unique, 100% means very unique.",
		value_default = 1,
		value_min = 0,
		value_max = 2.5,
		value_display_multiplier = 40,
		value_display_formatting = " $0%",
		scope = MOD_SETTING_SCOPE_RUNTIME,
	},
	]]--
	{
		id = "visibility",
		ui_name = "Glow-in-the-dark dialogue",
		ui_description = "Whether or not dialogue is visible through the dark.",
		value_default = false,
		scope = MOD_SETTING_SCOPE_RUNTIME,
	},
	{
		id = "hamis",
		ui_name = "informal hämis",
		ui_description = "whether or not hämis speak informally like they should :thumbsup:",
		value_default = true,
		scope = MOD_SETTING_SCOPE_RUNTIME,
	},
	{
		id = "stupid",
		ui_name = "stupid mode",
		ui_description = "randomize every line of dialogue.",
		value_default = false,
		scope = MOD_SETTING_SCOPE_RUNTIME,
	},
	--[[ funny but not too novel I think
	{
		id = "stupider",
		ui_name = "stupider mode",
		ui_description = "ultra randomize every line of dialogue.",
		value_default = false,
		scope = MOD_SETTING_SCOPE_RUNTIME,
	},
	]]--
}

-- This function is called to ensure the correct setting values are visible to the game via ModSettingGet(). your mod's settings don't work if you don't have a function like this defined in settings.lua.
-- This function is called:
--		- when entering the mod settings menu (init_scope will be MOD_SETTINGS_SCOPE_ONLY_SET_DEFAULT)
-- 		- before mod initialization when starting a new game (init_scope will be MOD_SETTING_SCOPE_NEW_GAME)
--		- when entering the game after a restart (init_scope will be MOD_SETTING_SCOPE_RESTART)
--		- at the end of an update when mod settings have been changed via ModSettingsSetNextValue() and the game is unpaused (init_scope will be MOD_SETTINGS_SCOPE_RUNTIME)
function ModSettingsUpdate( init_scope )
	local old_version = mod_settings_get_version( mod_id ) -- This can be used to migrate some settings between mod versions.
	mod_settings_update( mod_id, mod_settings, init_scope )
end

-- This function should return the number of visible setting UI elements.
-- Your mod's settings wont be visible in the mod settings menu if this function isn't defined correctly.
-- If your mod changes the displayed settings dynamically, you might need to implement custom logic.
-- The value will be used to determine whether or not to display various UI elements that link to mod settings.
-- At the moment it is fine to simply return 0 or 1 in a custom implementation, but we don't guarantee that will be the case in the future.
-- This function is called every frame when in the settings menu.
function ModSettingsGuiCount()
	return mod_settings_gui_count( mod_id, mod_settings )
end

-- This function is called to display the settings UI for this mod. Your mod's settings wont be visible in the mod settings menu if this function isn't defined correctly.
function ModSettingsGui( gui, in_main_menu )
	mod_settings_gui( mod_id, mod_settings, gui, in_main_menu )
end
