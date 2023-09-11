# lite-xl-notes

### These are notes on creating documentation for lite-xl

## core dev recommends:
I'd say the main concepts that might be useful for a new plugin dev are:
commands and their predicates
keymaps
commandview:enter
Doc/DocView methods
an explanation on how you can override everything
 
maybe also something about rootview/rootnod

## pathlist:

the full pathlist is in data/core/start.lua

#### per core developer:

basically looks in DATADIR and USERDIR

with a priority for USERDIR

## Tutorial layout rough draft:

This will be built upon a rolling implementation on the same plugin.

The end programmer will see how the plugin evolves.

0. the most basic tutorial, the base layout of a plugin
1. keymap shortcuts
2. running a thing from keymap shortcuts
3. interfacing into lite-xl from thing
4. a simple button that does a thing that also does the thing from the previous key shortcut
5. a simple button that does a thing to make another button
6. a group of buttons
7. a drop down menu
8. a window like the settings window
9. put things into the window
10. editing helpers (scope, indentation, etc)
11. Not sure yet, find out more important things to make the plugin more advanced!
