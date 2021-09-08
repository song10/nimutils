import docopt
import strutils
import strformat
import pegs
import os

let
  app_dir = getAppDir()
  app_dat = joinPath(app_dir, "xcd.dat")

if not fileExists app_dat:
  open(app_dat, fmWrite).close()

proc find(name: string): string =
  for line in lines app_dat:
    if line =~ peg"@@',' {.+}":
      var id, path: string
      (id, path) = matches
      if id == name:
        return path
  return ""

proc add(name: string): string =
  # stderr instead of stdout
  write(stderr, &"# {name} -> ")
  flushFile(stderr)
  var input = readLine(stdin)
  let f = open(app_dat, fmAppend)
  defer: f.close()
  # f.setFilePos(0, fspEnd)
  f.writeLine(&"{name},{input}")
  return input

proc execute*(args: Table[system.string, docopt.Value]) =
  let prefix = "# nu xcd\n"
  var script = ""
  if not args["<name>"]:
    # "cd" as default
    script = "cd"
  else:
    let target = $args["<name>"]
    if target =~ peg"^\d$":
      # "cd{n}" go upper n-level folder
      let path = "../".repeat(target.parseInt())
      script = &"cd {path}"
    else:
      # "cd {target}" create target if not existed
      let find = target.find()
      var path: string;
      if find == "":
        path = target.add()
      else:
        path = find
      if path[0] != '~':
        path = &"'{path}'"
      script = &"cd {path}\ntitle '{target}'"

  # write script
  let tmpfile = "/tmp/xcd.sh"
  let f = open(tmpfile, fmWrite)
  defer: f.close()
  f.writeLine(prefix & script)

  # return script path
  echo tmpfile
