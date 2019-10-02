#!/usr/bin/env bash

##
# Démarrage du flux local en plein écran
# avec option tout répéter pour une reprise si rupture de flux
# et quelques ajustements de l'interface...
##

INPUT_STREAM="udp://@:1234"
VLC_OPTIONS="--loop --fullscreen --autoscale --no-video-title --no-macosx-fspanel --mouse-hide-timeout 0"

# l'avantage d'ouvrir la vidéo avec open est qu'il rend la main
open "$INPUT_STREAM" -a "/Applications/VLC.app" --args $VLC_OPTIONS

# ouverture synchrone
#vlc "$INPUT_STREAM" $VLC_OPTIONS

