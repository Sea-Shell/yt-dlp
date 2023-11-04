FROM python:3.12-alpine as base

RUN apk update && \
    apk add dumb-init && \
    adduser --disabled-password --uid 1000 --home /opt/yt-dlp yt-dlp && \
    pip install -qqq pipenv

FROM base AS build

RUN apk add build-base libffi-dev openssl-dev musl-dev cargo
USER 1000
COPY Pipfile /opt/yt-dlp/Pipfile
COPY Pipfile.lock /opt/yt-dlp/Pipfile.lock
WORKDIR /opt/yt-dlp
RUN pipenv install
COPY entrypoint.sh /opt/yt-dlp/entrypoint.sh

FROM base AS prod

ENV LC_ALL C.UTF-8
ENV PYTHONUNBUFFERED 1
WORKDIR /opt/yt-dlp
RUN apk add ffmpeg
USER 1000
COPY --chown=1000:1000 --from=build /opt/yt-dlp /opt/yt-dlp

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/opt/yt-dlp/entrypoint.sh"]