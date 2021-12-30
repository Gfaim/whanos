#!/bin/bash

if [ $1 == "" ]; then
    # >&2 echo "./getLanguage.py [folder]\n\tfolder: folder path (default: current folder)"
    echo "WHY"
    exit 1
fi

EXTENSIONS=("c:Makefile" "java:app/pom.xml" "javascript:package.json" "python:requirements.txt" "befunge:app/main.bf")
FOUND=()

for ext in "${EXTENSIONS[@]}"; do
    KEY=${ext%%:*}
    VALUE=${ext#*:}

    if test -f $1/$VALUE; then
        FOUND+=($KEY)
    fi
done

if [[ ${#FOUND[@]} -eq 0 ]]; then
    >&2 echo "No valid extension found"
    exit 1
elif [[ ${#FOUND[@]} -gt 1 ]]; then
    >&2 echo "Multiple extensions found"
    exit 1
else
    echo "${FOUND[0]}"
    exit 0
fi