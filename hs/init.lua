--[[
defaults write org.hammerspoon.Hammerspoon MJConfigFile 'path/to/here'

sudo hidutil property --set '{'UserKeyMapping': [{'HIDKeyboardModifierMappingSrc':0x700000029, 'HIDKeyboardModifierMappingDst':0x700000039},{'HIDKeyboardModifierMappingSrc':0x700000039,'HIDKeyboardModifierMappingDst':0x700000029},{'HIDKeyboardModifierMappingSrc':0x700000035,'HIDKeyboardModifierMappingDst':0x70000006D}]}'
]]
hs.loadSpoon('EmmyLua')

---@diagnostic disable: lowercase-global
hyper = require('hyper')
hyper.bind('r', hs.reload)
print('------------ RELOAD -----------')
hs.alert('Hammerspoon: config loaded')

---@diagnostic disable: lowercase-global
window = require('window')
hyper.bind('h', window.tile_left)
hyper.bind('l', window.tile_right)
hyper.bind('k', window.tile_up)
hyper.bind('j', window.tile_down)
hyper.bind('c', window.center)
hyper.bind('f', window.full)
hyper.bind('=', window.larger)
hyper.bind('-', window.smaller)
hyper.bind('u', window.up)
hs.hotkey.bind({ 'command', 'alt', 'control' }, 'Right', window.move_space_right)
hs.hotkey.bind({ 'command', 'alt', 'control' }, 'Left', window.move_space_left)

local function app(name)
  return function ()
    hs.application.open(name)
  end
end
hyper.bind('s', app('Spotify'))
hyper.bind('b', app('Brave Browser'))
hyper.bind('m', app('Mail'))
hyper.bind('t', app('Telegram'))
hyper.bind('w', app('WhatsApp'))
hyper.bind('s', app('Spotify'))
hyper.bind('i', app('Iterm'))

-- require('appswitcher')

-- hs.hotkey.bind({}, '', hs.caffeinate.lockScreen)
