# Healthchecker

Minimal docker image for website healthchecking.

## Environment Variables

- `CHECK_URL`: The URL to check. Required.
- `REPORT_URL`: The URL to report the healthcheck result to. Required.
    - failure will be sent to `REPORT_URL/fail`.
- `CRON`: The cron expression for scheduling healthchecks. (default: `* * * * *`)
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
```

## Deployment:

`./deploy.sh`
