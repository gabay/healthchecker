#!/bin/sh

FAILURE_COUNT_FILE="/tmp/healthchecker_failures"

# Wrapper for HTTP requests with sensible defaults
request() {
    curl -fsS --max-time 10 --retry 3 "$@"
}

debug() {
    if [ -n "$DEBUG" ]; then
        echo "$@"
    fi
}

# Execute health check
OUTPUT=$(request "$CHECK_URL" 2>&1)
EXIT_CODE=$?
debug "Exit code: $EXIT_CODE. Output: $OUTPUT"

if [ "$EXIT_CODE" -eq 0 ]; then
    # Success
    echo 0 > "$FAILURE_COUNT_FILE"
    request "${REPORT_URL}" >/dev/null
else
    # Failure: increment counter
    FAILURES=$(cat "$FAILURE_COUNT_FILE" 2>/dev/null || echo 0)
    FAILURES=$((FAILURES + 1))
    echo "$FAILURES" > "$FAILURE_COUNT_FILE"

    if [ "$REPORT_FAILURE_THRESHOLD" -eq -1 ] || [ "$FAILURES" -lt "$REPORT_FAILURE_THRESHOLD" ]; then
        debug "Failure count: $FAILURES. Reporting to /log"
        request "${REPORT_URL}/log" --data-raw "$OUTPUT" >/dev/null
    else
        debug "Failure count: $FAILURES. Reporting to /fail"
        request "${REPORT_URL}/fail" --data-raw "$OUTPUT" >/dev/null
    fi
fi
