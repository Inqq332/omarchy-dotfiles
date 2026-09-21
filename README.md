# 🐧 Omarchy Dotfiles Backup

Личные конфигурационные файлы (dotfiles) для дистрибутива Omarchy Linux.

## ⚡ Быстрый старт

### Установить конфиги на систему

```bash
cd ~/dotfiles && ./setup.sh
```

Интерактивный меню — выбираете нужный блок, он копируется в `~/.config/` **с автоматической .bak-копией**.

### Собрать текущие конфиги из системы в репозиторий

```bash
cd ~/dotfiles && ./setup.sh
# выберите пункт "📥 Сбор конфигов (pull)"
```

Скрипт копирует все файлы из `~/.config/` и `~/` обратно в `~/dotfiles/`. Новые файлы, которых нет в репозитории, появляются с пометкой `+`, изменённые — с `~`.

## 📂 Структура каталогов репозитория

Каждый файл из таблицы можно установить отдельным пунктом. Пункт в скобках — номер/символ меню.

| Папка / файл | Куда попадает | Что хранит |
|---|---|---|
| `hypr/` → `monitors.lua` (~/.config/hypr/) | Раскладка мониторов (3 монитора или только Philips). **Только пункт 1.** |
| `hypr/` → `hyprland.lua` (~/.config/hypr/) | Главный конфиг Hyprland: загрузка Omarchy-дефолтов, порядок personal-overrides. Пункт 2. |
| `hypr/` → `bindings.lua` (~/.config/hypr/) | Горячие клавиши — отмена стандартных, новые бинды (скриншоты, VS Code, Telegram, private browser). Пункт 3. |
| `hypr/` → `input.lua` (~/.config/hypr/) | Раскладка клавиатуры (us+ru, Alt+Shift toggle), gaps_in/out, border_size. Пункт 4. |
| `hypr/` → `autostart.lua` (~/.config/hypr/) | Автозапуск сервисов и AmneziaVPN. Пункт 5. |
| `hypr/` → `looknfeel.lua` (~/.config/hypr/) | Глобальные настройки внешнего вида (gaps, borders, анимации) — только примеры-комментарии. Пункт 6. |
| `hypr/` → `monitors_triple.lua` | Шаблон: 3 монитора (TMN + Xiaomi, Philips отключён). Не копируется напрямую — используется пунктом 1. |
| `hypr/` → `monitors_philips.lua` | Шаблон: только Philips телевизор. Аналогично — пункт 1. |
| `hypr/` → `toggle_monitors.sh` (~/.config/hypr/) | Скрипт быстрого переключения мониторов (F7). Копируется вместе с monitors.lua. |
| `hypr/` → `hyprsunset.conf` (~/.config/hypr/) | Настройка night light (цветовая температура) — по умолчанию отключён. Пункт 7. |
| `hypr/` → `xdph.conf` (~/.config/hypr/) | Screen capture настройки (screencopy для Wayland). Пункт 8. |
| `foot/` → `foot.ini` (~/.config/foot/) | Терминал Foot: шрифт, размер, pad, скроллбек, привязки буфера обмена. Пункт 9. |
| `tmux/` → `tmux.conf` (~/.config/tmux/) | Tmux: виж-режим, префикс C-Space, навигация панелями, статус-бар. Пункт 10. |
| `nvim/` (весь каталог) → ~/.config/nvim/ | Neovim: LazyVim, lazy-lock.json, плагины, автокоманды. Копирует всё recursively. Пункт 11. |
| `vscode/` → `settings.json` → ~/.config/Code/User/ | VS Code: тема «Ocean Green: Dark», профили терминала (tmux по умолчанию), git.autofetch. Пункт 12. |
| `vscode/` → `keybindings.json` → ~/.config/Code/User/ | VS Code: Ctrl+V и Shift+Insert для вставки в терминал. Пункт 12. |
| `omarchy/shell.json` → ~/.config/omarchy/ | Оболочка Omarchy: idle (150s/300s), раскладка бара, темы. Пункт 13. |
| `omarchy/branding/` | Обои и branding (`about.txt`, `screensaver.txt`). Собираются pull-пунктом, не копируются вручную. |
| `omarchy/extensions/` | Расширения меню Quickshell (`omarchy-menu.jsonc`). Pull-пункт. |
| `omarchy/hooks/*/` | Хуки: post-update (install-voxtype, setup-agent, setup-fingerprint), pre-refresh-pacman, font-set и др. Pull-пункт. |
| `XCompose` → ~/ | Комбинации для быстрых символов и эмодзи. Пункт 14. |

## 📌 Ручная установка

```bash
# Каждый файл создаёт .bak перед заменой:
cp -f hypr/hyprland.lua    ~/.config/hypr/
cp -f hypr/bindings.lua    ~/.config/hypr/
cp -f hypr/input.lua       ~/.config/hypr/
cp -f hypr/autostart.lua   ~/.config/hypr/
cp -rf nvim/*              ~/.config/nvim/
cp -f vscode/settings.json  ~/.config/Code/User/
```

## 🔄 После установки Hyprland

```bash
hyprctl reload      # применить настройки
```
