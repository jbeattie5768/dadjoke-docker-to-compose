FROM alpine:3.20
RUN apk add --no-cache bash curl
COPY update-joke.sh /update-joke.sh
RUN chmod +x /update-joke.sh
CMD ["/update-joke.sh"]
