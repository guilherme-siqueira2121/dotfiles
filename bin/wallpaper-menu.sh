#!/usr/bin/env bash
# Wallpaper menu usando rofi

WALLPAPER_DIR="$HOME/dotfiles/wallpapers/all"
CURRENT="$HOME/dotfiles/wallpapers/current/wall.jpg"

# Verificar se pasta existe
if [ ! -d "$WALLPAPER_DIR" ]; then
    notify-send "Erro" "Pasta de wallpapers não encontrada"
    exit 1
fi

# Verificar se há wallpapers na pasta
if [ -z "$(ls -A "$WALLPAPER_DIR")" ]; then
    notify-send "Erro" "Nenhum wallpaper encontrado na pasta"
    exit 1
fi

# Listar wallpapers com rofi
SELECTED=$(ls -1 "$WALLPAPER_DIR" | rofi -dmenu -i -p "Escolha um wallpaper" \
    -theme-str 'window {width: 50%;}' \
    -theme-str 'listview {columns: 1; lines: 10;}')

# Se selecionou algo
if [ -n "$SELECTED" ]; then
    WALLPAPER_PATH="$WALLPAPER_DIR/$SELECTED"

    # Copiar para o wallpaper atual
    cp "$WALLPAPER_PATH" "$CURRENT"

    # Aplicar com swww
    swww img "$WALLPAPER_PATH" \
        --transition-fps 60 \
        --transition-type wipe \
        --transition-duration 2

    notify-send "Wallpaper" "Aplicado: $SELECTED"
fi
