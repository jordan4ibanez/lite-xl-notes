-- mod-version:3

--[[

So the first line isn't just a comment for our sakes.

The first line designates what version of lite-xl this plugin was made for.

It's parsed by the IDE to denote if it's out of date.

Very important, don't forget it.

I know this can look a bit overwhelming, but if you read through it, you'll understand what's going on.

Now, let's get to some basics.


-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


Q: What is a module?

A: A module is just a localized grouping of code that does something or is a framework to allow other modules to do things.

Possibly both! Now don't think too deeply into this, because what you're looking at right now is, in fact, a module. :)


Q: How can I make modules depend on eachother?

A: Well, we're getting to that right now, with the require function.

]]--

-- The "core" module. The base of lite-xl.
local core = require "core"

-- The "command" module will help us register commands for our plugin.
local command = require "core.command"

-- The "style" module will allow us to use styling options.
local style = require "core.style"

-- The "config" module will be used to store certain things like colors and functions.
local config = require "core.config"

-- The "keymap" module will allow us to set keybindings for our commands.
local keymap = require "core.keymap"

--[[

As you can see, we've been localizing all these imported modules so they don't leak into global scope.

Now, let me explain a bit of info about why we're going to import rootview:


-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


RootView is a View that manages all the other Views.

It gets input from Core and dispatches it to all the Views.

It contains the rootnode which is a Node.

Nodes are the system that manage splits and tabs.

Splits are the division of two gui elements. Like when you move a tab to the side and it makes a split view.

Tabs are the tabs, if you're reading this in lite-xl the tab at the top says "tutorial_1.lua". Easy enough.

Think of RootView as the window manager for lite-xl.

Since we want to modify RootView, we'll need to require it first.

]]--

local RootView = require "core.rootview"

--[[

As you can see, we've been requiring core modules for everything we've been doing!

If you wanted to make a dependency on another plugin, it's quite simple.


local MyModule = require "plugins.my_module"

Pretty simple, right? This imported module would just be called "my_module.lua" in the plugins folder.


Something I want you to notice: Now we're using the words "plugin" and "module" interchangeably!

This is because they use the same scheme. A plugin IS a module.


Don't worry, we'll touch up on this later in the tutorial. And if I forgot to, call me out on it.

Let's focus on this one for now.

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

We're going to make a configuration for this plugin.

We imported the config module and that's what we use to store per-plugin settings, pretty neat huh?

So it's utilized by creating a table in config.plugins.your_plugin_name. Where your_plugin_name is the name of the plugin.

Since this plugin is called tutorial_1, we can just do this:

]]--

config.plugins.tutorial_1 = {}


--[[

Colors. Everyone loves colors! You're looking at a bunch of colors right now.

Q: But how do we use colors in lite-xl?

A: There are 2 possible ways to do this! Both quite simple. Let's see below.

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

1: Literals

Literals are RGB or RGBA formatted integral (whole number) tables. Internally, it utilizes UBYTE. This means 0-255 are valid input on each element.

So what am I talking about? Well, let me show you:

Red
config.plugins.tutorial_1.text_color = { 255, 0, 0 }

Translucent Gray
config.plugins.tutorial_1.text_color = { 127, 127, 127, 127 }


As you can see, it's quite simple. The alpha channel in Red Blue Green Alpha is optional! Automatically gets set to 255 if left out.

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

2: Hex

If you want to use hex literals, it's also quite simple. Just import common like so:

local common = require "core.common"

A note for the format. Just like literals, there are two options: RRGGBB and RRGGBBAA. AA stands for hex alpha channel

Red
config.plugins.tutorial_1.text_color = { common.color "#FF0000" }

Translucent Gray
config.plugins.tutorial_1.text_color = { common.color "#80808080" } <- that last 80 is the alpha channel :) 50%

A handy guide for hex alpha channel: https://gist.github.com/lopspower/03fb1cc0ac9f32ef38f4

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

We're going to use violet because it's quite visible:

]]--

config.plugins.tutorial_1.text_color = { 200, 140, 220 }


--[[

We're going to now create a function to calculate the position of our text.

We could do this as a local function. But remember: If we do this it's not extensible!

But the nice way to do this would be to store your function in the config.

Using a local it might be a few...nanoseconds faster but is that worth removing the modularity out of the module?

If we store this function in the config, that means that people can build on top of it, override it, OR they 
could straight call it inside of their module.

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

So the function's argument will be the text that we want to display. 

This is so we can determine the X and Y position of the text!

]]--

function config.plugins.tutorial_1.get_text_position(message)
  --[[
  
  So we're trying to display this text on the top right of the editor.

  For this, we need to know the editor's width and height.

  The current font's size can be obtrained from the "style" module.

  The editor's dimensions can be obtained by:
  core.root_view.size.x
  core.root_view.size.y
  
  ]]--

  local message_width = style.code_font:get_width(message .. " ")

  local font_height = style.code_font:get_size()

  local x = core.root_view.size.x - message_width

  local y = font_height / 2

  return x, y
end


--[[

Now we're going to actually draw something inside the editor.

In order to inject our own code to draw text we're going to have to save the original draw function.

We're going to save Rootview.draw to a variable we call parent_draw.

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

So basically what's happening is as so:

1. We save the old function
2. We create a new one
3. In the new function we call the old one so the editor still functions.

We are extending the original function and basically shoveling more code into it!

]]--

local parent_draw = RootView.draw

-- We're going to overload the original definition of draw in RootView by redefining the function.

function RootView:draw()

  -- Now here's where we call the original function.
  parent_draw(self)

  --[[

  So right now show_my_message is nil. Luckily for us this also means false in an if statement.
  
  We're going to add this variable in later to check if we want to show our message or not.

  We can also use inverted logic gates to do deflective returns!
  
  ]]--

  if not config.plugins.tutorial_1.show_my_message then return end

  --[[
  
  We're going to store the message in this local variable.

  If it doesn't exist, it'll just say "Tutorial message not set!"

  If it does, well, that's the message. :)

  We can use that nil = false logic to automate this, very easily!
  
  ]]--

  local message = config.plugins.tutorial_1.my_cool_message or "Tutorial message not set!"

  -- Now we get the text coordinates from our function we made earlier!
  
  local x,y = config.plugins.tutorial_1.get_text_position(message)

  --[[
  
  Finally, we can draw the text into the editor.

  The draw_text function from renerer is an important function as it is used to display any and all text inside of the editor window!
  
  ]]--

  renderer.draw_text(style.code_font, message, x, y, config.plugins.tutorial_1.text_color)

end

--[[

Now, we want the end user to allow this message to be turned on or off.

We can write a simple function to allow this. This is what I was talking about earlier. :D

We can make it extensible by putting it into the config table!

]]--

function config.plugins.tutorial_1.toggle_message()
  -- Here's that nil = false boolean logic coming into play again. :)
  config.plugins.tutorial_1.show_my_message = not config.plugins.tutorial_1.show_my_message
end

--[[

Next, let's make a function that intakes user input from the command bar!

core.command_view:enter takes 2 arguments:
  * The prompt to display before taking put.
  * A function that takes the input as it's argument.

And of course, we'll put this into the config so that it can be extended or changed!

]]--

function config.plugins.tutorial_1.input_message()

  -- Entering into the command bar, we pass it a function to execute when you hit enter.
  
  core.command_view:enter("Text to display", {
    submit = function(text)
      config.plugins.tutorial_1.my_cool_message = text
      config.plugins.tutorial_1.show_my_message = true
    end
  })
end



--[[

Finally, we're going to add the toggle visibility and set message functions into the command list.

ALT + S = Set the message.

ALT + T = Toggle the message visibility.

This is quite a simple task, but please observe how this is done:

]]--

local commands_to_add = {}

commands_to_add["tutorial_1:set_message"] = config.plugins.tutorial_1.input_message

commands_to_add["tutorial_1:toggle_message"] = config.plugins.tutorial_1.toggle_message

command.add(nil, commands_to_add)

--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

local new_keymaps = {}

new_keymaps["alt+s"] = "tutorial_1:set_message"

new_keymaps["alt+t"] = "tutorial_1:toggle_message"

keymap.add(new_keymaps)


print("Tutorial 1 loaded!")
