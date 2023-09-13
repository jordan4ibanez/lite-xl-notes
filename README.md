# lite-xl-notes

### These are notes on creating documentation for lite-xl

## core dev recommends:

I'd say the main concepts that might be useful for a new plugin dev are:

1. commands and their predicates
2. keymaps
3. commandview:enter
4. Doc/DocView methods
5. an explanation on how you can override everything
 
maybe also something about rootview/rootnod

## pathlist:

the full pathlist is in data/core/start.lua

#### per core developer:

basically looks in ``DATADIR`` and ``USERDIR``

with a priority for ``USERDIR``

## Tutorial layout rough draft:

This will be built upon a rolling implementation on the same plugin.

The end programmer will see how the plugin evolves.

Less comments to reinforce memorization of what's happening in the plugin.

Also increases information density, so they can reads what's going on faster.

0. [the most basic tutorial, the base layout of a plugin](https://github.com/jordan4ibanez/lite-xl-notes/blob/main/tutorials/tutorial_0/tutorial_0.lua)
1. [keymap shortcuts & running a thing from keymap shortcuts](https://github.com/jordan4ibanez/lite-xl-notes/blob/main/tutorials/tutorial_1/tutorial_1.lua)
2. interfacing into lite-xl from thing
3. a simple button that does a thing that also does the thing from the previous key shortcut
4. a simple button that does a thing to make another button
5. a group of buttons
6. a drop down menu
7. a tab window, utilizing the ``View`` module
8. put things into the window
9. editing helpers (scope, indentation, etc)
10. Not sure yet, find out more important things to make the plugin more advanced!

# BEGIN LITE XL API DOCUMENTATION

**NOTE:** The order in which functions are laid out are in the order they appear in the source code.

## Module core

### Depencies:

- core.strict
- core.regex
- core.common
- core.config
- colors.default

### Exports:

- core (table)

### Functions:

#### `core.set_project_dir ( new_dir, change_project_fn )`
* new_dir = 
  * A directory literal.
* change_project_fn = <Optional>
  * A function literal to tell core how to change directories.
