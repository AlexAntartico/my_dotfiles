#!/usr/bin/env bash
#
# Description: Linux mint saves screenshots with a leading/trailing ' and with spaces in
# between names so I execute this in the folder they are bein saved and returns
# a readable, manipulable better name for *nix systems. Save under alis in your
# .bash_aliases file
#
# Author: Ed Mendoza
# Date: 12/11/2025
# Features: 1) removes leading/trailin single quotes 2) substitutes whitespaces with
# underscores
# License: MIT
# 
# after doing this, remove metadata from ss, in same dir run: exiftool -all= .

for file in ./*; do
    # Skip if not a file 
    [[ -f "$file" ]] || continue

    filename="${file##*/}"

    # Strip leading/trailing single quotes if present
    clean="$filename"
    # #% are parameter expansions that rm shortes match of a single
    # quote from beginning of string and end of string respectively
    clean="${clean#\'}"    # Removes leading '
    clean="${clean%\'}"    # Removes trailing '

    # using extended globbing here, just google if not familiar
    shopt -s extglob 2>/dev/null
    clean="${clean##+([[:space:]])}"
    clean="${clean%%+([[:space:]])}"

    clean="${clean// /_}"

    # Only rename if name changed
    if [[ "$filename" != "$clean" ]]; then
        mv -v "$file" "./$clean"
    fi
done 
