FROM alpine:3.21
RUN apk add --no-cache curl jq
USER 1000:1000
ENTRYPOINT ["/bin/sh"]
