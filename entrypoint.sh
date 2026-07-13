#!/bin/sh

# Validate required environment variables
if [ -z "$CHECK_URL" ] || [ -z "$REPORT_URL" ]; then
    echo "ERROR: CHECK_URL and REPORT_URL must be set" >&2
    exit 1
fi

# Set cron schedule with default (every minute)
export CRON="${CRON:-* * * * *}"

echo "Healthchecker starting."

# Enable verbose logging if DEBUG is set
LOG_LEVEL=9
if [ -n "$DEBUG" ]; then
    LOG_LEVEL=8
    echo "CHECK_URL=${CHECK_URL}"
    echo "REPORT_URL=${REPORT_URL}"
    echo "CRON=${CRON}"
fi

# Schedule health check via cron and run daemon
echo "${CRON} /check.sh" > /etc/crontabs/root
crond -f -l "$LOG_LEVEL"
