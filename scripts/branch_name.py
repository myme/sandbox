#!/usr/bin/env python3
#
# Generate a branch name from some "random" input
#
# This script simply creates a sensible git-friendly branch name from some stdin
# input.
#

import re, sys

def main():
    [first, *words] = (
        re.sub("[^0-9a-zA-Z_-]", "", word)
        for word in sys.stdin.read().split()
    )

    rest = "-".join(word.lower() for word in words)
    result = "/".join([first, rest])

    print(result)


if __name__ == "__main__":
    main()
