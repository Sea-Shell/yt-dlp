#!/bin/bash
set -e
set -x

id

ls -lah /library/disk2/library/music/ogg/

pip install yt-dlp

~/.local/bin/yt-dlp --config-locations ~/yt-dlp/.config/youtube-dl/config