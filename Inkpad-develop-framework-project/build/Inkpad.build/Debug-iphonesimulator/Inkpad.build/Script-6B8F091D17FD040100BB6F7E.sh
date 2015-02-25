#!/bin/sh
find . -name '*.[m,mm]' | xargs genstrings -o en.lproj
