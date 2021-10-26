import strutils

proc execErr(cmd: string, exitMsg: string= "", exitCode: int = 1): string =
  let (outR, errR) = gorgeEx(cmd)
  if errR != 0:
    echo outR
    echo exitMsg
    quit(exitCode)
  result = outR

discard execErr("nimble refresh", exitCode = 2)

let outp = execErr("nimble list --installed", exitCode = 1)

echo "Installed packages:"
echo outp
echo ""

let out_lines = splitLines(outp)
for line in out_lines:
  let package = line.split({' '})[0]
  echo "Updating " & package
  let (outP, errP) = gorgeEx("nimble -y install " & package)
  if errP != 0:
     echo "Error!"
     echo outP
  else:
     echo "Done\n"