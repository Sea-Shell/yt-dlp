FROM docker.io/library/ubuntu:22.04

COPY entrypoint.sh /entrypoint.sh

RUN chmod 1777 /tmp && apt update && apt install -yqq ffmpeg python3 python3-pip
RUN useradd -m -u 1000 -s /bin/bash abc && addgroup abc users

USER 1000
RUN pip3 install --user yt-dlp
CMD ["/entrypoint.sh"]
