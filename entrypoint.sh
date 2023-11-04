#!/bin/bash
set -x

pipenv -v run yt-dlp --config-locations ~/yt-dlp/.config/youtube-dl/config || exit 0
