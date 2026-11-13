FROM alpine:3.20
# Base image is pinned; Alpine drops old package versions, so pinning apk packages breaks builds over time.
# hadolint ignore=DL3018
RUN apk add --no-cache bash curl
COPY update-joke.sh /update-joke.sh
RUN chmod +x /update-joke.sh
CMD ["/update-joke.sh"]
