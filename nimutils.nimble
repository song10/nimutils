# Package

version       = "0.1.0"
author        = "Rex Zhuo"
description   = "Utilities with Nim"
license       = "MIT"
srcDir        = "src"
installExt    = @["nim"]
bin           = @["nimutils", "vii"]


# Dependencies

requires "nim >= 1.4.8"
requires "docopt"
requires "neel"
requires "cligen"
requires "unpack"
