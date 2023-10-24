FROM ubuntu:22.04

ADD entrypoint.sh /entrypoint.sh

RUN apt update
RUN apt install -yqq ffmpeg python3 python3-pip
RUN useradd -m -u 1000 -s /bin/bash abc
RUN addgroup abc users

USER 1000
CMD ["/entrypoint.sh"]
