#!/bin/bash

MYWEB_STATUS_FILE="/root/mywebStatus.txt"
PROBE=".feeler.html"
TIMEOUT=10

if [[ ! -r $MYWEB_STATUS_FILE ]]; then
    echo "Error: $MYWEB_STATUS_FILE is not readable."
    exit 1
fi

if ! command -v nmap >/dev/null 2>&1; then
    echo "Error: nmap command not found."
    exit 1
fi

while read -r i; do
    echo "## Target site $i"
    echo -n "  Port status: "
    nmap -sS "$i" -p 80 | awk '/80\/tcp/{print $2}'
    echo -n "  Service status: "
    if wget -q -T "$TIMEOUT" "http://$i/$PROBE" >/dev/null 2>&1; then
        echo "ok"
    else
        echo "not ok"
    fi
    echo "done"
done < "$MYWEB_STATUS_FILE"