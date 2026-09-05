#!/bin/bash

CONFIG_DIR="$HOME/.config/hypr"
MAIN_CONFIG="$CONFIG_DIR/monitors.lua"
PHILIPS_CONFIG="$CONFIG_DIR/monitors_philips.lua"
TRIPLE_CONFIG="$CONFIG_DIR/monitors_triple.lua"

# Проверяем, выключен ли сейчас Philips в основном конфиге
if grep -q "HDMI-A-1.*disabled = true" "$MAIN_CONFIG"; then
    # Если Philips выключен, значит сейчас режим 3 мониторов. Включаем только его:
    cp "$PHILIPS_CONFIG" "$MAIN_CONFIG"
    notify-send "Мониторы" "Включен монитор: Philips (HDMI)" -i display
else
    # Иначе возвращаем режим трех мониторов:
    cp "$TRIPLE_CONFIG" "$MAIN_CONFIG"
    notify-send "Мониторы" "Включен режим: Стандартный режим" -i display
fi

# Применяем изменения в Hyprland
hyprctl reload
