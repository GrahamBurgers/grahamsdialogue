return 
---@param font string
---@param text string
---@return number
function(font, text)
	local width = 0
	local custom_font_data = dofile("mods/grahamsdialogue/files/font_data/" .. font .. ".lua")
	for i = 1, #text do
		width = width + (custom_font_data[text:sub(i, i)] or 0)
	end
	return width / 2
end
