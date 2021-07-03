import unittest
import nimutilspkg/lib/path

test "to windows format":
  check to_win_format("""/apc01/c/Users/Song10/test.c""") == """\apc01\c\Users\Song10\test.c"""
test "to unix format":
  check to_nix_format("""\\apc01\c\Users\Song10\test.c""") == """//apc01/c/Users/Song10/test.c"""
