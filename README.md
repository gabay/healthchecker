# Healthchecker

Minimal docker image for website healthchecking.

## Environment Variables

- `CHECK_URL`: The URL to check. Required.
- `REPORT_URL`: The URL to report the healthcheck result to. Required.
    - non-alerting failure will be sent to `REPORT_URL/log`.
    - alerting failure will be sent to `REPORT_URL/fail`.
- `CRON`: The cron expression for scheduling healthchecks. (default: `* * * * *`)
- `REPORT_FAILURE_THRESHOLD`: The number of consecutive check failures required to report to `/fail`. (default: `1`, set to `-1` to always report to `/log` and never to `/fail`).
- `DEBUG`: If set, environment variables and cron runs will be logged.

## Usage example

Docker:

```bash
docker run -d --init -e CHECK_URL=<insert check URL> -e REPORT_URL=<insert report URL> gabay/healthchecker
```

Docker Compose:

```yaml
services:
    healthchecker:
        image: gabay/healthchecker
        init: true
        environment:
            - CHECK_URL=<insert check URL>
            - REPORT_URL=<insert report URL>
            - CRON="*/5 * * * *"
            - FAILED_CHECKS_FOR_REPORTING_FAILURE=3
```

## Deployment:

`./deploy.sh`
