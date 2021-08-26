let doc = """
Utility with Nim.

Usage:
  un path [--win | --nix] <path>
  un hosts <hostname>
  un (-h | --help)
  un --version

Options:
  -h --help     Show this screen.
  --version     Show version.
  --win         Convert to Windows format.
  --nix         Convert to *nix format.
"""

import docopt
from nimutilspkg/lib/path import execute
from nimutilspkg/lib/hosts import execute

let args = docopt(doc, version = "Utility with Nim 0.1")

if args["path"]:
  path.execute(args)
elif args["hosts"]:
  hosts.execute(args)
else:
  echo doc
