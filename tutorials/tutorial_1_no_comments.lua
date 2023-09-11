-- mod-version:3

local core = require "core"
local command = require "core.command"
local style = require "core.style"
local config = require "core.config"
local keymap = require "core.keymap"
local RootView = require "core.rootview"

config.plugins.tutorial_1 = {}

config.plugins.tutorial_1.text_color = { 200, 140, 220 }

function config.plugins.tutorial_1.get_text_position(message)
  local message_width = style.code_font:get_width(message .. " ")
  local font_height = style.code_font:get_size()
  local x = core.root_view.size.x - message_width
  local y = font_height / 2

  return x, y
end

local parent_draw = RootView.draw

function RootView:draw()
  parent_draw(self)

  if not config.plugins.tutorial_1.show_my_message then return end

  local message = config.plugins.tutorial_1.my_cool_message or "Tutorial message not set!"
  local x,y = config.plugins.tutorial_1.get_text_position(message)
  
  renderer.draw_text(style.code_font, message, x, y, config.plugins.tutorial_1.text_color)
end

function config.plugins.tutorial_1.toggle_message()
  config.plugins.tutorial_1.show_my_message = not config.plugins.tutorial_1.show_my_message
end

function config.plugins.tutorial_1.input_message()
  core.command_view:enter("Text to display", {
    submit = function(text)
      config.plugins.tutorial_1.my_cool_message = text
      config.plugins.tutorial_1.show_my_message = true
    end
  })
end

local commands_to_add = {}
commands_to_add["tutorial_1:set_message"] = config.plugins.tutorial_1.input_message
commands_to_add["tutorial_1:toggle_message"] = config.plugins.tutorial_1.toggle_message

command.add(nil, commands_to_add)

local new_keymaps = {}
new_keymaps["alt+s"] = "tutorial_1:set_message"
new_keymaps["alt+t"] = "tutorial_1:toggle_message"

keymap.add(new_keymaps)

print("Tutorial 1 No Comments loaded!")
