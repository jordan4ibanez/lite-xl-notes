-- mod-version:3

--[[

So the first line isn't just a comment for our sakes.

The first line designates what version of lite-xl this plugin was made for.

It's parsed by the IDE to denote if it's out of date.

Very important, don't forget it.

I know this can look a bit overwhelming, but if you read through it, you'll understand what's going on.

Now, let's get to some basics.


--------------------------------------------------------


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

-- The "config" module will be used to store certain things like and functions.
local config = require "core.config"

-- The "keymap" module will allow us to set keybindings for our commands.
local keymap = require "core.keymap"

--[[

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





]]--


