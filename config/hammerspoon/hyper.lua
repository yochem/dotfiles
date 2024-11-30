local M = {}

-- does this need to be global?
local hyper_mode = hs.hotkey.modal.new()

local function enterHyperMode()
	hyper_mode.triggered = false
	hyper_mode:enter()
end

local function exitHyperMode()
	hyper_mode:exit()
	if not hyper_mode.triggered then
		hs.eventtap.keyStroke({}, '`')
	end
end

function M.bind(key, func)
	hyper_mode:bind({}, key, function ()
		func()
		hyper_mode.triggered = true
	end)
end

FOREVERGLOBAL = hs.hotkey.bind({}, 'F18', enterHyperMode, exitHyperMode)

hs.hotkey.bind({"shift"}, 'F18', function ()
	hs.eventtap.keyStroke({"shift"}, "`")
end)

return M
