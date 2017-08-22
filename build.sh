#!/usr/bin/env bash

use_lulpeg=false
fake_lfs=false
run_tests=false

if [[ $* == *--fake_lfs* ]]; then
  fake_lfs=true
fi

if [[ $* == *--lulpeg* ]]; then
  use_lulpeg=true
  if [ ! -f lulpeg.lua ]; then
    wget https://raw.githubusercontent.com/pygy/LuLPeg/master/lulpeg.lua
  fi
fi

if [[ $* == *--test* ]]; then
  run_tests=true
fi


if [ ! -f amalg.lua ]; then
  wget https://raw.githubusercontent.com/siffiejoe/lua-amalg/master/src/amalg.lua
fi

if [ ! -d moonscript ]; then
  git clone https://github.com/leafo/moonscript
fi

cd moonscript
moon_libs=`find moonscript | sed -e 's/\//./g' | grep .lua | sed -e 's/.lua//g'`
moon_source=`lua ../amalg.lua $moon_libs`

cd ..
lulpeg_source=`lua amalg.lua lulpeg | sed -e 's/lulpeg/lpeg/g'`

lfs_cheat="
-- Fake lfs
package.preload[ \"lfs\" ] = function() end
"

the_lib="
return {
  insert_loader = require \"moonscript.base\".insert_loader,
  compile = require \"moonscript.cmd.moonc\".compile_file_text,
}
"

echo "$moon_source" > moonyscript.lua
if $use_lulpeg ; then
  echo "$lulpeg_source" >> moonyscript.lua
fi
if $fake_lfs ; then
  echo "$lfs_cheat" >> moonyscript.lua
fi

echo "$the_lib" >> moonyscript.lua

if $run_tests ; then
  lua tests/run_tests.lua
fi

echo "All done"
