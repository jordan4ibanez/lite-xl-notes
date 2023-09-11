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

It gets input from Core and dispatches it to all the View.

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

Pretty simple, right? this imported module would just be called "my_module.lua" in the plugins folder.


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



