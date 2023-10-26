#!/bin/bash
set -x

~/.local/bin/yt-dlp --config-locations ~/yt-dlp/.config/youtube-dl/config || exit 0
