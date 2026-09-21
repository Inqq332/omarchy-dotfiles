#!/bin/bash

CONFIG_DIR="$HOME/.config/hypr"
# Теперь цель — файл, который создала утилита и который загружается последним:
TARGET_CONFIG="$CONFIG_DIR/hyprmoncfg-monitors.lua"

PHILIPS_CONFIG="$CONFIG_DIR/monitors_philips.lua"
TRIPLE_CONFIG="$CONFIG_DIR/monitors_triple.lua"

# Проверяем через hyprctl, активен ли сейчас Philips (не отключен ли он)
if hyprctl monitors | grep -q "PHILIPS"; then
    echo "Philips сейчас активен. Переключаем на стандартный режим (3 монитора)..."
    cp "$TRIPLE_CONFIG" "$TARGET_CONFIG"
    notify-send "Мониторы" "Включен режим: Стандартный (3 монитора)" -i display
else
    echo "Philips выключен. Переключаем ТОЛЬКО на Philips..."
    cp "$PHILIPS_CONFIG" "$TARGET_CONFIG"
    notify-send "Мониторы" "Включен режим: Только Philips (HDMI)" -i display
fi

# Применяем изменения в Hyprland
hyprctl reload
