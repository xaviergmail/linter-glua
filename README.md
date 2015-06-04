linter-glua
===========
## Requirements

You will need the following:

* [Atom Linter](https://atom.io/packages/linter).
* [cartman3000's gluac executable](http://facepunch.com/showthread.php?t=1442142&p=46729787&viewfull=1).


> gluac — gluac is a variant of luac, which parses (Garry's Mod) lua files. It can be used for detecting errors in (Garry's Mod) lua scripts. See [http://www.lua.org/manual/4.0/luac.html](http://www.lua.org/manual/4.0/luac.html) for more informations about luac.

This package will lint your currently open `.lua` files in Atom through gluac. **It will lint on edit and/or save**, so you are able to immediately see any errors in your script.

Due to the behavior of luac, it will only notify you of the first error found in the file.

## Installation

* `$ apm install linter` (if you don't have [Atom Linter](https://atom.io/packages/linter) installed).

* `$ apm install linter-glua`

## Configuration

Atom -> Preferences... -> Packages -> Linter lua -> Settings:

* **Executable** Path to your `gluac` executable, if not on your system's PATH environment variable.
