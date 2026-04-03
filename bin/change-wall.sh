#!/usr/bin/env bash

WALLS="$HOME/dotfiles/wallpapers/all"
CURRENT="$HOME/dotfiles/wallpapers/current/wall.jpg"

if [ ! -d "$WALLS" ]; then
    notify-send "Erro" "Pasta de wallpapers não encontrada"
    exit 1
fi

RANDOM_WALL=$(find "$WALLS" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | shuf -n 1)

if [ -z "$RANDOM_WALL" ]; then
    notify-send "Erro" "Nenhum wallpaper encontrado"
    exit 1
fi

if ! pgrep -x awww-daemon > /dev/null; then
    awww-daemon &
    sleep 0.5
fi

cp "$RANDOM_WALL" "$CURRENT"

awww img "$RANDOM_WALL" \
    --transition-fps 60 \
    --transition-type wipe \
    --transition-duration 2

notify-send "Wallpaper" "$(basename "$RANDOM_WALL")"