#!/usr/bin/env bash

##
# configuration du projet
##

# données sources en 16:9
declare -r CLA_BACKGROUND_IMG="$ABS_PATH/habillage-club-ados.jpg"
declare -r MED_BACKGROUND_IMG="$ABS_PATH/habillage-mediatheque.jpg"

declare -r CLA_STREAM="http://live.adhocmusic.com:80/club-ados.ts"
declare -r MED_STREAM="http://live.adhocmusic.Com:80/mediatheque.ts"

# canevas de travail en pixels
declare -r CANVAS_WIDTH=1280
declare -r CANVAS_HEIGHT=720
declare -r CANVAS_MARGIN=20

# calcul taille des vidéos et positionnement
declare -r REMOTE_STREAM_SCALE=0.85
declare -r REMOTE_STREAM_WIDTH=$(bc <<< "($CANVAS_WIDTH - 2 * $CANVAS_MARGIN) * $REMOTE_STREAM_SCALE / 1")
declare -r REMOTE_STREAM_HEIGHT=$(bc <<< "($CANVAS_HEIGHT - 2 * $CANVAS_MARGIN) * $REMOTE_STREAM_SCALE / 1")
declare -r REMOTE_STREAM_X=$CANVAS_MARGIN
declare -r REMOTE_STREAM_Y=$CANVAS_MARGIN
declare -r LOCAL_STREAM_SCALE=0.25
declare -r LOCAL_STREAM_WIDTH=$(bc <<< "($CANVAS_WIDTH - 2 * $CANVAS_MARGIN) * $LOCAL_STREAM_SCALE / 1")
declare -r LOCAL_STREAM_HEIGHT=$(bc <<< "($CANVAS_HEIGHT - 2 * $CANVAS_MARGIN) * $LOCAL_STREAM_SCALE / 1")
declare -r LOCAL_STREAM_X=$(bc <<< "$CANVAS_WIDTH - $CANVAS_MARGIN - $LOCAL_STREAM_WIDTH")
declare -r LOCAL_STREAM_Y=$(bc <<< "$CANVAS_HEIGHT - $CANVAS_MARGIN - $LOCAL_STREAM_HEIGHT")

# paramètres de sortie
declare -r OUTPUT_CONTAINER="mpegts"
declare -r OUTPUT_VIDEO_CODEC="libx264"
declare -r OUTPUT_VIDEO_BITRATE="1000k"
declare -r OUTPUT_WIDTH=1280
declare -r OUTPUT_HEIGHT=720
declare -r OUTPUT_HOST=127.0.0.1
declare -r OUTPUT_PORT=1234
declare -r OUTPUT_PACKET_SIZE=1316

