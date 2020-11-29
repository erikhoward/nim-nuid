packageName   = "nuid"
version       = "0.1.0"
author        = "Erik Howard (erikhoward)"
description   = "A nim implementation of nats NUID."
license       = "MIT"
srcDir        = "src"
skipDirs      = @["test"]


# Dependencies

requires "nim >= 1.4.0"
requires "random"

# Helper functions

proc test(name: string, defaultLang = "c") =
  if not dirExists "build":
    mkDir "build"
  if not dirExists "nimcache":
    mkDir "nimcache"
  --run
  --nimcache: "nimcache"
  switch("out", ("./build/" & name))
  setCommand defaultLang, "tests/" & name & ".nim"

# tasks
task test, "Run all tests":
  test "test_core"

