#!/usr/bin/env bash
# Omarchy dotfiles installer — modular, interactive.
# Installs individual blocks with .bak backups before overwriting.

set -euo pipefail
cd "$(dirname "$0")"

CONF="$HOME/.config"
CHOICE=""

# ── helpers ────────────────────────────────────────────────────────────────

backup() {
    # Creates a .bak copy if the target already exists.
    local dest_path="$1"          # full path on disk
    if [[ -f "$dest_path" ]]; then
        cp -f "$dest_path" "${dest_path}.bak"
        echo "  → ${dest_path}.bak created"
    fi
}

monitor_menu() {
    echo ""
    echo "📺 Выбор конфигурации мониторов:"
    echo "  1) 3 монитора  (TMN + Xiaomi, Philips выкл)"
    echo "  2) Только Philips (HDMI)"
    echo "  q) Назад"
    echo ""
    read -rp "Ваш выбор: " mchoice

    case "$mchoice" in
        1)
            backup "$CONF/hypr/monitors.lua"
            cp -f hypr/monitors_triple.lua "$CONF/hypr/monitors.lua"
            echo "  → monitors.lua → режим 3 монитора"
            ;;
        2)
            backup "$CONF/hypr/monitors.lua"
            cp -f hypr/monitors_philips.lua "$CONF/hypr/monitors.lua"
            echo "  → monitors.lua → только Philips"
            ;;
        q|Q|*) return ;;
    esac
}

pull_config() {
    echo ""
    echo "📥 Сбор текущих конфигов в ~/dotfiles/…"
    echo ""

    # Only pull files that are ALREADY tracked in this repo.
    # Prevents: copying ~/.config/omarchy/omarchy/... back as omarchy/omarchy/,
    #           creating nested duplicates from tools that install their own hierarchy.
    git ls-files -z | tr '\0' '\n' | while IFS= read -r tracked; do
        local dst_dir
        dst_dir=$(dirname "$tracked")

        if [[ "$dst_dir" == "vscode" ]]; then
            # VS Code files come from ~/.config/Code/User/<file>
            case "$tracked" in
                settings.json) local_src="$CONF/Code/User/settings.json" ;;
                keybindings.json) local_src="$CONF/Code/User/keybindings.json" ;;
                *) continue ;;
            esac
        elif [[ "$tracked" == "XCompose" ]]; then
            local_src="$HOME/XCompose"
        else
            # Normal config dir: ~/.config/<dir>/<path> = ~/dotfiles/<path>
            local top_dir="${tracked%%/*}"
            case "$top_dir" in
                foot|hypr|nvim|tmux|omarchy)
                    local rel_sub="${tracked#$top_dir/}"
                    local_src="$CONF/$top_dir/$rel_sub"
                    ;;
                *) continue ;;  # skip unmanaged tracked files
            esac
        fi

        [[ ! -f "$local_src" ]] && continue

        if [[ ! -f "$tracked" ]]; then
            mkdir -p "$(dirname "$tracked")"
            cp -f "$local_src" "$tracked"
            printf "    + %s\n" "$tracked"
        elif ! cmp -s "$local_src" "$tracked"; then
            cp -f "$local_src" "$tracked"
            printf "    ~ %s\n" "$tracked"
        fi
    done

    # Remove files that were tracked but no longer exist at their old location.
    git ls-files --deleted 2>/dev/null | while IFS= read -r gone; do
        local src="$CONF/${gone#*/}"  # rough mapping
        if [[ ! -d "$HOME/dotfiles" ]]; then continue; fi
    done

    echo ""
    echo "Готово. Проверь изменения: git diff --stat"
}

# ── main menu ──────────────────────────────────────────────────────────────

while true; do
    echo ""
    echo "═══════════════════════════════════"
    echo "  Omarchy Dotfiles Installer"
    echo "═══════════════════════════════════"
    echo ""
    echo "  📥  Сбор конфигов (pull)          — из ~/.config в ~/dotfiles/"
    echo "  ─────────────────────────────────────────────"
    echo "  1)  Настройки мониторов           (monitors.lua)"
    echo "  2)  Hyprland главный конфиг       (hyprland.lua)"
    echo "  3)  Горячие клавиши               (bindings.lua)"
    echo "  4)  Ввод / раскладка             (input.lua)"
    echo "  5)  Автозапуск                    (autostart.lua)"
    echo "  6)  Внешний вид                   (looknfeel.lua)"
    echo "  7)  Hyprsunset                    (hyprsunset.conf)"
    echo "  8)  XDPh (screencopy)            (xdph.conf)"
    echo "  9)  Терминал Foot                 (foot.ini)"
    echo " 10)  Tmux                         (tmux.conf)"
    echo " 11)  Neovim                       (nvim/ → ~/.config/nvim/)"
    echo " 12)  VS Code                      (settings + keybindings)"
    echo " 13)  Omarchy shell.json            (shell.json)"
    echo " 14)  XCompose                     (~/.XCompose)"
    echo ""
    echo "  q)  Выход"
    echo ""
    read -rp "Ваш выбор [📥, 1-14, q]: " CHOICE

    case "$CHOICE" in
        "📥"|PULL|pull|Pull)
            pull_config
            ;;
        1)
            monitor_menu
            ;;
        2)
            backup "$CONF/hypr/hyprland.lua"
            cp -f hypr/hyprland.lua "$CONF/hypr/hyprland.lua"
            echo "  → $CONF/hypr/hyprland.lua installed"
            ;;
        3)
            backup "$CONF/hypr/bindings.lua"
            cp -f hypr/bindings.lua "$CONF/hypr/bindings.lua"
            echo "  → $CONF/hypr/bindings.lua installed"
            ;;
        4)
            backup "$CONF/hypr/input.lua"
            cp -f hypr/input.lua "$CONF/hypr/input.lua"
            echo "  → $CONF/hypr/input.lua installed"
            ;;
        5)
            backup "$CONF/hypr/autostart.lua"
            cp -f hypr/autostart.lua "$CONF/hypr/autostart.lua"
            echo "  → $CONF/hypr/autostart.lua installed"
            ;;
        6)
            backup "$CONF/hypr/looknfeel.lua"
            cp -f hypr/looknfeel.lua "$CONF/hypr/looknfeel.lua"
            echo "  → $CONF/hypr/looknfeel.lua installed"
            ;;
        7)
            backup "$CONF/hypr/hyprsunset.conf"
            cp -f hypr/hyprsunset.conf "$CONF/hypr/hyprsunset.conf"
            echo "  → $CONF/hypr/hyprsunset.conf installed"
            ;;
        8)
            backup "$CONF/hypr/xdph.conf"
            cp -f hypr/xdph.conf "$CONF/hypr/xdph.conf"
            echo "  → $CONF/hypr/xdph.conf installed"
            ;;
        9)
            mkdir -p "$CONF/foot"
            backup "$CONF/foot/foot.ini"
            cp -f foot/foot.ini "$CONF/foot/foot.ini"
            echo "  → $CONF/foot/foot.ini installed"
            ;;
        10)
            mkdir -p "$CONF/tmux"
            backup "$CONF/tmux/tmux.conf"
            cp -f tmux/tmux.conf "$CONF/tmux/tmux.conf"
            echo "  → $CONF/tmux/tmux.conf installed"
            ;;
        11)
            mkdir -p "$CONF/nvim"
            backup "$CONF/nvim/init.lua"
            cp -rf nvim/. "$CONF/nvim/"
            echo "  → nvim/ synced to $CONF/nvim/"
            ;;
        12)
            mkdir -p "$CONF/Code/User"
            backup "$CONF/Code/User/settings.json"
            cp -f vscode/settings.json "$CONF/Code/User/settings.json"
            backup "$CONF/Code/User/keybindings.json"
            cp -f vscode/keybindings.json "$CONF/Code/User/keybindings.json"
            echo "  → VS Code settings & keybindings installed"
            ;;
        13)
            mkdir -p "$CONF/omarchy"
            backup "$CONF/omarchy/shell.json"
            cp -f omarchy/shell.json "$CONF/omarchy/shell.json"
            echo "  → $CONF/omarchy/shell.json installed"
            ;;
        14)
            if [[ -f ~/.XCompose ]]; then
                backup "$HOME/.XCompose"
            fi
            cp -f XCompose "$HOME/.XCompose"
            echo "  → ~/.XCompose installed"
            ;;
        q|Q)
            echo "Готово!"
            exit 0
            ;;
        *)
            echo "Неизвестный выбор: $CHOICE"
            ;;
    esac
done
