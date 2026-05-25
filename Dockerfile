FROM python:3.15.0b1-alpine@sha256:8fe37a98f64ee15fee985b1536cc005aef67847c31f435772250165307a68c2e as base

RUN apk update && \
    apk add dumb-init && \
    adduser --disabled-password --uid 1000 --home /opt/ytdlp yt-dlp && \
    pip install -qqq pipenv

FROM base AS build

RUN apk add build-base libffi-dev openssl-dev musl-dev cargo
USER 1000
COPY Pipfile /opt/ytdlp/Pipfile
COPY Pipfile.lock /opt/ytdlp/Pipfile.lock
WORKDIR /opt/ytdlp
RUN pipenv install
COPY entrypoint.sh /opt/ytdlp/entrypoint.sh

FROM base AS prod

ENV LC_ALL C.UTF-8
ENV PYTHONUNBUFFERED 1
WORKDIR /opt/ytdlp
RUN apk add ffmpeg
USER 1000
COPY --chown=1000:1000 --from=build /opt/ytdlp /opt/ytdlp

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/opt/ytdlp/entrypoint.sh"]