import sys

from . import hello

if len(sys.argv) > 1:
    hello(sys.argv[1])
else:
    hello()
