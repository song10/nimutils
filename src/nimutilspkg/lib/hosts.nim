import docopt
import strutils
import osproc
import strformat
import pegs

proc to_win_format*(txt: string): string = txt.replace('/', '\\')
proc to_nix_format*(txt: string): string = txt.replace('\\', '/')

proc execute*(args: Table[system.string, docopt.Value]) =
  let
    host = $args["<hostname>"]
    outp = execProcess(&"ip a")
    lines = outp.splitLines

  var sub, num: string
  for x in lines:
    if x =~ peg"@ {\d+\.\d+\.\d+} '.' {\d+} '/24'":
      (sub, num) = matches
      if args["<hostname>"] and sub != host:
        continue
      break

  if sub.len > 0:
    echo &"""

# num hosts
#10.0.15.69 atctlc01.andestech.com
10.0.15.60 atcsqa03
10.0.15.69 atctlc01
10.0.15.70 atctlc02
10.0.1.71  gitea
10.0.1.245 atclnx01
10.0.1.241 atcpcw01

{sub}.73  hostpc
{sub}.108 winvb
{sub}.1   manvb
"""    
