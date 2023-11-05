#!/bin/sh
set -x

pipenv -v run yt-dlp --config-locations ~/.config/youtube-dl/config || exit 0
