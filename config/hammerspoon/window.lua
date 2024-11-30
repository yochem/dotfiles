local M = {}

local function half2thirds(frame_size, screen_size, in_position)
	-- 1/2 -> 1/3
	if in_position and frame_size == math.floor(screen_size / 2) then
		return screen_size / 3
	end

	-- 1/3 -> 2/3
	if in_position and frame_size == math.floor(screen_size / 3) then
		return screen_size / 3 * 2
	end

	-- 2/3 -> 1/2 or coming from other position
	return screen_size / 2
end

M.tile_left = function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen():frame()

	local already_in_pos = f.x == screen.x and f.y == screen.y and f.h == f.h
	f.w = half2thirds(f.w, screen.w, already_in_pos)
	f.x = screen.x
	f.y = screen.y
	f.h = screen.h
	win:setFrame(f)
end

M.tile_right = function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen():frame()

	local already_in_pos = f.x == screen.w - f.w and f.y == screen.y and f.h == screen.h
	f.w = half2thirds(f.w, screen.w, already_in_pos)
	f.x = screen.x + (screen.w - f.w)
	f.y = screen.y
	f.h = screen.h
	win:setFrame(f)
end

M.tile_up = function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen():frame()

	local already_in_pos = f.x == screen.x and f.y == screen.y and f.w == screen.w
	f.h = half2thirds(f.h, screen.h, already_in_pos)
	f.x = screen.x
	f.y = screen.y
	f.w = screen.w
	win:setFrame(f)
end

M.tile_down = function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen():frame()

	local already_in_pos = f.y == screen.h - f.h and f.x == screen.x and f.w == screen.w
	-- TODO: not working yet
	f.h = half2thirds(f.h, screen.h, already_in_pos)
	f.x = screen.x
	f.y = screen.y + (screen.h - f.h)
	f.w = screen.w
	win:setFrame(f)
end

M.center = function()
	local win = hs.window.focusedWindow()
	win:centerOnScreen()
	-- local f = win:frame()
	-- local screen = win:screen():frame()
	-- f.center = screen.center
	-- win:setFrame(f)
end

M.full = function()
	hs.window.focusedWindow():maximize()
	-- local screen = win:screen():frame()
	-- win:setFrame(screen)
end

M.larger = function ()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local prev_center = f.center
	f.h = f.h * 1.05
	f.w = f.w * 1.05
	f.center = prev_center
	win:setFrame(f)
end

M.smaller = function ()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local prev_center = f.center
	f.h = f.h * 0.95
	f.w = f.w * 0.95
	f.center = prev_center
	win:setFrame(f)
end

M.move_space_right = function ()
	local win = hs.window.focusedWindow()
	local space = hs.spaces.focusedSpace()
	hs.spaces.moveWindowToSpace(win, space + 1)
end

M.move_space_left = function ()
	local win = hs.window.focusedWindow()
	local space = hs.spaces.focusedSpace()
	hs.spaces.moveWindowToSpace(win, space - 1)
end

return M
