#!/usr/bin/env bash

##
# export de ffmpeg directement dans ffplay
##

ffmpeg -f avfoundation -video_size 1920x1080 -pixel_format uyvy422 -r 25 -i "0" -f rawvideo - | ffplay -f rawvideo -pixel_format uyvy422 -video_size 1920x1080 -

