#!/usr/bin/env bash

WALLS="$HOME/dotfiles/wallpapers/all"
CURRENT="$HOME/dotfiles/wallpapers/current/wall.jpg"

# Verifica se a pasta existe
if [ ! -d "$WALLS" ]; then
    notify-send "Erro" "Pasta de wallpapers não encontrada"
    exit 1
fi

# Escolhe um wallpaper aleatório
RANDOM_WALL=$(find "$WALLS" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | shuf -n 1)

if [ -z "$RANDOM_WALL" ]; then
    notify-send "Erro" "Nenhum wallpaper encontrado"
    exit 1
fi

# Atualiza o wallpaper atual
cp "$RANDOM_WALL" "$CURRENT"

# Aplica com swww
swww img "$RANDOM_WALL" \
    --transition-fps 60 \
    --transition-type wipe \
    --transition-duration 2

notify-send "Wallpaper trocado!" "$(basename "$RANDOM_WALL")"
