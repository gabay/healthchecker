#!/bin/sh

if [ -z "$CHECK_URL" ]; then
    echo "ERROR: CHECK_URL is not set"
    exit 1
fi
if [ -z "$REPORT_URL" ]; then
    echo "ERROR: REPORT_URL is not set"
    exit 1
fi

export CRON=${CRON:-"* * * * *"}

echo "Healthchecker starting."
LOG_LEVEL=9
if [ -n "$DEBUG" ]; then
    LOG_LEVEL=8
    echo "CHECK_URL=${CHECK_URL}"
    echo "REPORT_URL=${REPORT_URL}"
    echo "CRON=${CRON}"
fi


echo "${CRON} /check.sh" > /etc/crontabs/root
crond -f -l $LOG_LEVEL
