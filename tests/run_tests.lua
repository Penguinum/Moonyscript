#!/usr/bin/env lua

-- Run prom project root

local ms = require "moonyscript"

do
  assert(loadstring(ms.compile"return (x) -> x * x")()(3) == 9)
end

do
  local ok = pcall(require, "tests.require_test")
  assert(not ok)
end

do
  ms.insert_loader()
  local ok, msg = pcall(require, "tests.require_test")
  assert(ok, msg)
end

do
  assert(require("tests.require_test").square(10) == 100)
end
