#!/bin/sh

# Wrapper for HTTP requests with retry logic
request() {
    curl -fsS --max-time 10 --retry 3 "$@"
}

# Execute health check
OUTPUT=$(request "$CHECK_URL" 2>&1)
EXIT_CODE=$?

if [ -n "$DEBUG" ]; then
    echo "Exit code: $EXIT_CODE. Output: $OUTPUT"
fi

# Report results to endpoint
if [ "$EXIT_CODE" -eq 0 ]; then
    request "${REPORT_URL}" >/dev/null
else
    request "${REPORT_URL}/fail" --data-raw "$OUTPUT" >/dev/null
fi
