#!/usr/bin/env bash

##
# Stream vers le serveur icecast
# (pas de son)
#
# dépendances :
# bash
# ffmpeg
##

declare -r ABS_PATH="$( cd "$(dirname "$0")" || return; pwd -P )"

# shellcheck source=conf/check_input.conf.sh disable=SC1091
. "$ABS_PATH/config.sh"

# données sources en 16:9
declare -r BACKGROUND_IMG="./static-mediatheque.jpg"
#declare -r BACKGROUND_IMG="./static-club-ados.jpg"

# nom du périphérique de capture
declare -r INPUT_STREAM="/dev/video0"

# todo dans le fichier de config direct
declare -r OUTPUT_CONTAINER="mpegts"
declare -r OUTPUT_VIDEO_CODEC="libx264"
declare -r OUTPUT_VIDEO_BITRATE="1000k"
declare -r OUTPUT_WIDTH=1280
declare -r OUTPUT_HEIGHT=720
declare -r OUTPUT_PROTOCOL="icecast"
declare -r OUTPUT_USER="source"
declare -r OUTPUT_PASS="xxxxxxxx"
declare -r OUTPUT_HOST="live.adhocmusic.com"
declare -r OUTPUT_PORT=80
declare -r OUTPUT_MOUNTPOINT="club-ados.ts"
#declare -r OUTPUT_MOUNTPOINT="mediatheque.ts"

ffmpeg \
    -loop 1 \
    -re \
    -i "$BACKGROUND_IMG" \
    -an \
    -g 10 \
    -cluster_size_limit 2M \
    -cluster_time_limit 5100 \
    -content_type video/mp2ts \
    -c:v "$OUTPUT_VIDEO_CODEC" \
    -b:v $OUTPUT_VIDEO_BITRATE \
    -f "$OUTPUT_CONTAINER" \
    -loglevel debug \
    "$OUTPUT_PROTOCOL://$OUTPUT_USER:$OUTPUT_PASS@$OUTPUT_HOST:$OUTPUT_PORT/$OUTPUT_MOUNTPOINT"
