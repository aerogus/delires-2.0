#!/usr/bin/env bash

##
# Composition vidéo
# Lit 2 flux udp + 1 image de fond
# les superpose et les stream en udp localement
#
# Pour la lecture, utiliser VLC :
# vlc udp://@127.0.0.1:1234
#
# dépendances :
# bash
# ffmpeg
# bc
##

declare -r ABS_PATH="$( cd "$(dirname "$0")" || return; pwd -P )"

# shellcheck source=conf/check_input.conf.sh disable=SC1091
. "$ABS_PATH/config.sh"

if [ -z "$1" ]; then
  echo "Usage: stream-local-compo.sh club-ados|mediatheque"
  exit 1
elif [ "$1" == "club-ados" ]; then
  declare -r BACKGROUND_IMG=$CLA_BACKGROUND_IMG
  declare -r REMOTE_STREAM=$MED_STREAM
  declare -r LOCAL_STREAM=$CLA_STREAM
elif [ "$1" == "mediatheque" ]; then
  declare -r BACKGROUND_IMG=$MED_BACKGROUND_IMG
  declare -r REMOTE_STREAM=$CLA_STREAM
  declare -r LOCAL_STREAM=$MED_STREAM
else
  echo "Usage: stream-local-compo.sh club-ados|mediatheque"
  exit 1
fi

# lancement du stream local
ffmpeg \
    -loop 1 \
    -re \
    -i "$BACKGROUND_IMG" \
    -i "$REMOTE_STREAM" \
    -i "$LOCAL_STREAM" \
    -filter_complex " \
        nullsrc=size="$CANVAS_WIDTH"x"$CANVAS_HEIGHT" [base]; \
        [0:v] scale="$CANVAS_WIDTH"x"$CANVAS_HEIGHT" [bg]; \
        [1:v] setpts=PTS-STARTPTS, scale="$REMOTE_STREAM_WIDTH"x"$REMOTE_STREAM_HEIGHT" [remote]; \
        [2:v] setpts=PTS-STARTPTS, scale="$LOCAL_STREAM_WIDTH"x"$LOCAL_STREAM_HEIGHT" [local]; \
        [base][bg] overlay=shortest=1 [bg2]; \
        [bg2][remote] overlay=shortest=1:x="$REMOTE_STREAM_X":y="$REMOTE_STREAM_Y" [tmp1]; \
        [tmp1][local] overlay=shortest=1:x="$LOCAL_STREAM_X":y="$LOCAL_STREAM_Y", scale="$OUTPUT_WIDTH"x"$OUTPUT_HEIGHT" \
    " \
    -an \
    -c:v $OUTPUT_VIDEO_CODEC \
    -b:v $OUTPUT_VIDEO_BITRATE \
    -f $OUTPUT_CONTAINER \
    udp://$OUTPUT_HOST:$OUTPUT_PORT?pkt_size=$OUTPUT_PACKET_SIZE

