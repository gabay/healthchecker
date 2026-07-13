FROM alpine

RUN apk add --no-cache curl

COPY --chmod=+x entrypoint.sh check.sh /
ENTRYPOINT [ "/entrypoint.sh" ]
