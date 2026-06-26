#!/usr/bin/env bash
WALLPAPER_DIR="$HOME/Wallpapers"

if [ -z "$(ls -A "$WALLPAPER_DIR" 2>/dev/null)" ]; then
    notify-send "RandWP" "Папка ~/Wallpapers порожня!"
    exit 1
fi

NEW_WP=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" \) | shuf -n 1)

# Генеруємо кольори
wal -i "$NEW_WP"

# КОПІЮЄМО ГОТОВІ КОНФІГИ З ПИВАЛ (як у setwp)
mkdir -p ~/.config/wofi
cp -f ~/.cache/wal/wofi.css ~/.config/wofi/style.css
mkdir -p ~/.config/mako
cp -f ~/.cache/wal/mako ~/.config/mako/config

# Оновлюємо картинку
magick "$NEW_WP" ~/.config/current_wallpaper.png
pkill swaybg
swaybg -m fill -i ~/.config/current_wallpaper.png &

# Релоади
pkill waybar && waybar &
makoctl reload
hyprctl reload

notify-send "RandWP" "Шпалери та тему успішно оновлено!"
