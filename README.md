linter-glua
===========

> gluac — The gluac is a variant of the luac, which parses (Garry's Mod) lua files. It can be used for detecting errors in lua code. See [http://www.lua.org/manual/4.0/luac.html](http://www.lua.org/manual/4.0/luac.html) for more informations about luac.

This package will lint your `.lua` opened files in Atom through luac or [luajit](http://luajit.org/running.html).  **It will lint on edit and/or save**, so you'll see instantly if your code has errors.

Due to the way that luac works it will only notify you of the first error found in the file.

## Linter Installation
Before using this package, you must ensure that `gluac` is installed on your system.

## Installation

* `$ apm install linter` (if you don't have [AtomLinter/Linter](https://github.com/AtomLinter/Linter) installed).
* `$ apm install linter-lua`

## Configuration

Atom -> Preferences... -> Packages -> Linter lua -> Settings:

* **Executable** Path to your `luac` or `luajit` executable.
