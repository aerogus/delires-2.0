#!/usr/bin/env bash

##
# permet une relance automatique du flux local
# en cas de coupure des flux distants
##

declare -r ABS_PATH="$( cd "$(dirname "$0")" || return; pwd -P )"

if [ -z "$1" ]; then
  echo "Usage: stream-local-compo-manager.sh club-ados|mediatheque"
  exit 1
elif [ "$1" != "club-ados" ] && [ "$1" != "mediatheque" ]; then
  echo "Usage: stream-local-compo-manager.sh club-ados|mediatheque"
  exit 1
fi

# Démarrage du VLC custom
"$ABS_PATH/start-vlc.sh"

while true; do
  "$ABS_PATH/stream-local-compo.sh" "$1"
  sleep 2
  echo "Redémarrage du flux local"
done

