# 🐧 Omarchy Dotfiles Backup

Личные конфигурационные файлы (dotfiles) для дистрибутива Omarchy Linux.

## 📂 Структура и пути восстановления

Эти папки и файлы нужно скопировать обратно в `~/.config/` (или домашнюю директорию `~/`) после чистой установки системы.

| Папка/Файл в репозитории | Оригинальный путь в системе | Что хранит |
|--------------------------|-----------------------------|------------|
| `hypr/`                  | `~/.config/hypr/`           | Настройки Hyprland: горячие клавиши (`autostart.lua`, `hyprland.lua`, `bindings.lua`), правила окон, мониторы. |
| `omarchy/`               | `~/.config/omarchy/`        | Настройки оболочки Omarchy: `shell.json` (таймауты сна, блокировки, layout бара), хуки, расширения меню. |
| `foot/`                  | `~/.config/foot/`           | Конфигурация терминала Foot (`foot.ini`). |
| `tmux/`                  | `~/.config/tmux/`           | Настройки мультиплексора Tmux. |
| `nvim/`                  | `~/.config/nvim/`           | Конфигурация редактора Neovim. |
| `XCompose`               | `~/.XCompose`               | Пользовательские комбинации для быстрых символов и эмодзи. |

## 🔄 Как восстановить после переустановки

1. Установите Omarchy и войдите в систему.
2. Установите Git и склонируйте этот репозиторий:
```bash
git clone git@github.com:inqq332/omarchy-dotfiles.git ~/dotfiles
cd ~/dotfiles
```
Скопируйте файлы на их законные места:
```bash
cp -r hypr ~/.config/
cp -r omarchy ~/.config/
cp -r foot ~/.config/
cp -r tmux ~/.config/
cp -r nvim ~/.config/
cp XCompose ~/
```
Скопируйте файлы на их законные места:
```bash
hyprctl reload
```