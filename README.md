# Healthchecker

Minimal docker image for arbitrary command healthchecking.

## Environment Variables

- `CHECK_URL`: The URL to check. Required.
- `REPORT_URL`: The URL to report the healthcheck result to. Required.
    - failure will be sent to `REPORT_URL/fail`.
- `CRON`: The cron expression for scheduling healthchecks. (default: `* * * * *`)
- `DEBUG`: If set, environment variables and cron runs will be logged.

## Deployment:

`./deploy.sh`
