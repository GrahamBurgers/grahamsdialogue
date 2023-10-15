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
		ui_description = "Whether or not enemies can speak when taking damage.",
		value_default = true,
		scope = MOD_SETTING_SCOPE_RUNTIME,
	},
	{
		id = "damaged",
		ui_name = "Damaged dialogue chance",
		ui_description = "The chance for an enemy to speak when taking damage.",
		value_default = 15,
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
	{
		id = "length",
		ui_name = "Dialogue duration",
		ui_description = "How long dialogue displays for. (60 frames = 1 second)\nNote that an enemy can't say a new line while they're already speaking one.",
		value_default = 180,
		value_min = 60,
		value_max = 360,
		value_display_formatting = " $0 frames",
		scope = MOD_SETTING_SCOPE_RUNTIME,
	},
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
		id = "visibility",
		ui_name = "Glow-in-the-dark dialogue",
		ui_description = "Whether or not dialogue is visible through the dark.",
		value_default = false,
		scope = MOD_SETTING_SCOPE_RUNTIME,
	},
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

	--example usage:
	--[[
	local im_id = 124662 -- NOTE: ids should not be reused like we do below
	GuiLayoutBeginLayer( gui )

	GuiLayoutBeginHorizontal( gui, 10, 50 )
    GuiImage( gui, im_id + 12312535, 0, 0, "data/particles/shine_07.xml", 1, 1, 1, 0, GUI_RECT_ANIMATION_PLAYBACK.PlayToEndAndPause )
    GuiImage( gui, im_id + 123125351, 0, 0, "data/particles/shine_04.xml", 1, 1, 1, 0, GUI_RECT_ANIMATION_PLAYBACK.PlayToEndAndPause )
    GuiLayoutEnd( gui )

	GuiBeginAutoBox( gui )

	GuiZSet( gui, 10 )
	GuiZSetForNextWidget( gui, 11 )
	GuiText( gui, 50, 50, "Gui*AutoBox*")
	GuiImage( gui, im_id, 50, 60, "data/ui_gfx/game_over_menu/game_over.png", 1, 1, 0 )
	GuiZSetForNextWidget( gui, 13 )
	GuiImage( gui, im_id, 60, 150, "data/ui_gfx/game_over_menu/game_over.png", 1, 1, 0 )

	GuiZSetForNextWidget( gui, 12 )
	GuiEndAutoBoxNinePiece( gui )

	GuiZSetForNextWidget( gui, 11 )
	GuiImageNinePiece( gui, 12368912341, 10, 10, 80, 20 )
	GuiText( gui, 15, 15, "GuiImageNinePiece")

	GuiBeginScrollContainer( gui, 1233451, 500, 100, 100, 100 )
	GuiLayoutBeginVertical( gui, 0, 0 )
	GuiText( gui, 10, 0, "GuiScrollContainer")
	GuiImage( gui, im_id, 10, 0, "data/ui_gfx/game_over_menu/game_over.png", 1, 1, 0 )
	GuiImage( gui, im_id, 10, 0, "data/ui_gfx/game_over_menu/game_over.png", 1, 1, 0 )
	GuiImage( gui, im_id, 10, 0, "data/ui_gfx/game_over_menu/game_over.png", 1, 1, 0 )
	GuiImage( gui, im_id, 10, 0, "data/ui_gfx/game_over_menu/game_over.png", 1, 1, 0 )
	GuiLayoutEnd( gui )
	GuiEndScrollContainer( gui )

	local c,rc,hov,x,y,w,h = GuiGetPreviousWidgetInfo( gui )
	print( tostring(c) .. " " .. tostring(rc) .." " .. tostring(hov) .." " .. tostring(x) .." " .. tostring(y) .." " .. tostring(w) .." ".. tostring(h) )

	GuiLayoutEndLayer( gui )
	]]--
end
