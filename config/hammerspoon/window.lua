local M = {}

local function move_window(movefn)
	return function ()
		local win = hs.window.focusedWindow()
		local frame = win:frame()
		local screen_frame = win:screen():frame()
		local new_frame = movefn(frame, screen_frame)
		win:setFrame(new_frame)
	end
end

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

M.tile_left = move_window(function(f, s)
	local already_in_pos = f.x == s.x and f.y == s.y and f.h == s.h
	f.w = half2thirds(f.w, s.w, already_in_pos)
	f.x = s.x
	f.y = s.y
	f.h = s.h
	return f
end)

M.tile_right = move_window(function(f, s)
	local already_in_pos = f.x == s.w - f.w and f.y == s.y and f.h == s.h
	f.w = half2thirds(f.w, s.w, already_in_pos)
	f.x = s.w - f.w
	f.y = s.y
	f.h = s.h
	return f
end)

M.tile_up = move_window(function(f, s)
	local already_in_pos = f.x == s.x and f.y == s.y and f.w == s.w
	f.h = half2thirds(f.h, s.h, already_in_pos)
	f.x = s.x
	f.y = s.y
	f.w = s.w
	return f
end)

M.tile_down = move_window(function(f, _)
	-- overwrite screen to account for menu bar
	local s = hs.window.focusedWindow():screen():fullFrame()
	local already_in_pos = f.y == s.h - f.h and f.x == s.x and f.w == s.w
	f.h = half2thirds(f.h, s.h, already_in_pos)
	f.x = s.x
	f.y = s.h - f.h
	f.w = s.w
	return f
end)

M.center = function()
	hs.window.focusedWindow():centerOnScreen()
end

M.full = function()
	hs.window.focusedWindow():maximize()
end

M.larger = move_window(function (f, _)
	local prev_center = f.center
	f.h = f.h * 1.05
	f.w = f.w * 1.05
	f.center = prev_center
	return f
end)

M.smaller = move_window(function (f, _)
	local prev_center = f.center
	f.h = f.h * 0.95
	f.w = f.w * 0.95
	f.center = prev_center
	return f
end)

M.up = move_window(function (f, _)
	f.y = 0
	return f
end)

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
