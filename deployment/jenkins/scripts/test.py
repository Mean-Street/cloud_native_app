#! /usr/bin/python3

if __name__ == "__main__":
    import sys
    import subprocess as sp

    error = 0

    error |= sp.call(["./tests/b.sh", "http://localhost", "1", "10"])

    sys.exit(error)
