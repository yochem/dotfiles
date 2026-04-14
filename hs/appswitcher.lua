Switcher = hs.window.switcher.new(
	hs.window.filter.new():setDefaultFilter({})
)
Switcher.ui.showTitles = true
Switcher.ui.showSelectedThumbnail = false
Switcher.ui.titleBackgroundColor = { 0, 0, 0, 0 }

local function mapCmdTab(event)
	local flags = event:getFlags()
	local chars = event:getCharacters()
	if chars == "\t" and flags:containExactly({ "cmd" }) then
		Switcher:next()
		return true
	end
end

TapCmdTab = hs.eventtap.new({ hs.eventtap.event.types.keyDown }, mapCmdTab)
TapCmdTab:start()
