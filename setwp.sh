#!/bin/bash

if [ -z "$1" ]; then
    echo "Юзай: setwp /шлях/до/картинки"
    exit 1
fi

WP_PATH=$(realpath "$1")

# 1. Генеруємо кольори для системи
wal -i "$WP_PATH"

# 2. Конвертуємо картинку в PNG (для Hyprland/Waybar/тощо)
magick "$WP_PATH" ~/.config/current_wallpaper.png

# 3. Перезапускаємо шпалери
pkill swaybg
swaybg -m fill -i ~/.config/current_wallpaper.png &

# 4. Рестартимо панель і демона сповіщень для нових кольорів
pkill waybar && waybar &
makoctl reload

echo "Шпалери, кольори, Waybar та Mako успішно оновлено!"
