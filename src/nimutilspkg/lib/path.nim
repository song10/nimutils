import docopt
import strutils

proc to_win_format*(txt: string): string = txt.replace('/', '\\')
proc to_nix_format*(txt: string): string = txt.replace('\\', '/')

proc execute*(args: Table[system.string, docopt.Value]) =
  var
    isNix: bool
    txt: string

  if args["--win"]: isNix = false
  # elif args["--nix"]: isNix = true
  else: isNix = true

  let
    input = $args["<path>"]

  if isNix:
    txt = input.to_nix_format
  else:
    txt = input.to_win_format

  echo txt
