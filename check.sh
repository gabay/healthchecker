#!/bin/sh

alias request="curl -fsS --max-time 10 --retry 3"

OUTPUT=$(request $CHECK_URL 2>&1)
EXIT_CODE=$?

if [ -n "$DEBUG" ]; then
    echo "Exit code: $EXIT_CODE. Output: $OUTPUT"
fi

if [ $EXIT_CODE -eq 0 ]; then
    request ${REPORT_URL} >/dev/null
else
    request ${REPORT_URL}/fail --data-raw "$OUTPUT" >/dev/null
fi
