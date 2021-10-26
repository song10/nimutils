import std/[os, pegs, strformat]
import cligen
import unpack

proc vii*(args: seq[string]): int =
  if args.len == 0:
    return 0

  var cmd: string
  while true:
    # $file(9, 11)
    # $file:9:11
    let arg = args[0]
    if arg =~ peg"@@ [(:] {\d+} @ {\d+} [)]?":
      [file, line, column] <- matches
      cmd = &"vim '+normal ${line}G${column}|' {file}"
      break

    # $file
    cmd = &"vim {arg}"
    break

  execShellCmd(cmd)

when isMainModule:
  dispatch(vii,
    # short = {"dry-run": 'n'},
      # help = {"verbose": "print chown and chmod calls as they happen"}
    )
