# Moonyscript
## What?
A script that converts [Moonscript](https://github.com/leafo/moonscript/) into single-file pure Lua library.

Default build (without LuLPeg and faking LuaFileSystem) is included as `moonyscript.lua`.

## Usage
`./build.sh [--lulpeg] [--fake_lfs] [--test]`
* --lulpeg — Use lulpeg library as LPeg replacement
* --fake_lfs — Use dummy library instead of LuaFileSystem (if you don't have it)
* --test — Run tests after finish

Output file will be `moonyscript.lua`

## Purpose
I want to use Moonscript but don't want to have dependencies in some kinds of projects.

## The library
Returns 2 functions: `compile(moonscript_source)` and `insert_loader()`
```lua
-- Examples
local ms = require "moonyscript"

local moonscript_source = [[
-- Moonscript source here
]]

local lua_source = ms.compile(moonscript_source)

ms.insert_loader()
-- Now you can directly require Moonscript modules
```

## Dependencies
* [`lua-amalg`](https://github.com/siffiejoe/lua-amalg) for converting sources into single file
* [`LuLPeg`](https://github.com/pygy/LuLPeg) — optional LPeg replacement
* [`Moonscript`](https://github.com/leafo/moonscript/), obviously

The script will try to download all dependencies automatically (except Unix environment with Lua, sorry).

## Known issues
* LuLPeg fails to parse `require`d code if there was moonyscript.compile invoked before
* build.sh correcly works only in Bash

## License
But it's a tiny shell script... Ok
### License (MIT)
Copyright (C) 2017 by Penguinum-tea

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
