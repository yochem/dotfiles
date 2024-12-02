hs.loadSpoon("EmmyLua")

local hyper = require('hyper')
hyper.bind('r', function()
  hs.reload()
end)
print("------------ RELOAD -----------")
hs.alert("Hammerspoon: config loaded")

local window = require('window')
hs.window.animationDuration = 0
hyper.bind('h', window.tile_left)
hyper.bind('l', window.tile_right)
hyper.bind("k", window.tile_up)
hyper.bind("j", window.tile_down)
hyper.bind("c", window.center)
hyper.bind("f", window.full)
hyper.bind("=", window.larger)
hyper.bind("-", window.smaller)
hyper.bind("u", window.up)
hs.hotkey.bind({ "command", "alt", "control" }, "Right", window.move_space_right)
hs.hotkey.bind({ "command", "alt", "control" }, "Left", window.move_space_left)

hyper.bind("s", function() hs.application.open("Spotify") end)
hyper.bind("b", function() hs.application.open("Brave Browser") end)
hyper.bind("m", function() hs.application.open("Mail") end)
hyper.bind("t", function() hs.application.open("Telegram") end)
hyper.bind("w", function() hs.application.open("WhatsApp") end)
hyper.bind("s", function() hs.application.open("Spotify") end)
hyper.bind("i", function() hs.application.open("Iterm") end)

require("appswitcher")

-- hs.hotkey.bind({}, "", hs.caffeinate.lockScreen)
