#!/usr/bin/env bash

# CPU и RAM
CPU=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
RAM=$(free -m | awk '/Mem:/ {printf "%.1f", $3/$2*100}')

# Автоопределение GPU (NVIDIA или AMD/Intel)
if command -v nvidia-smi &> /dev/null; then
    GPU_USAGE=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits | tr -d '[:space:]')
    GPU_MEM_MB=$(nvidia-smi --query-gpu=memory.used --format=csv,noheader,nounits | tr -d '[:space:]')
    GPU_MEM=$(awk "BEGIN {printf \"%.1f\", $GPU_MEM_MB/1024}")
else
    CARD_PATH=$(ls -d /sys/class/drm/card*/device 2>/dev/null | head -n 1)
    if [ -n "$CARD_PATH" ] && [ -f "$CARD_PATH/gpu_busy_percent" ]; then
        GPU_USAGE=$(cat "$CARD_PATH/gpu_busy_percent" 2>/dev/null || echo "0")
        if [ -f "$CARD_PATH/mem_info_vram_used" ]; then
            VRAM_BYTES=$(cat "$CARD_PATH/mem_info_vram_used")
            GPU_MEM=$(awk "BEGIN {printf \"%.1f\", $VRAM_BYTES/1024/1024/1024}")
        else
            GPU_MEM="0.0"
        fi
    else
        GPU_USAGE="0"; GPU_MEM="0.0"
    fi
fi

# Вывод СТРОГО одной строкой в JSON
TEXT="💻 CPU:${CPU}% | 💾 RAM:${RAM}% | 🎮 GPU:${GPU_USAGE}% (${GPU_MEM}GB)"
echo "{\"text\": \"$TEXT\"}"

