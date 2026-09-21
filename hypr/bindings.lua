-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Add a new binding.
--o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

-- Change an existing binding by unbinding it first, then binding the key again.
-- This example changes SUPER+SPACE from the launcher to the Omarchy root menu.
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu toggle root")

-- Disable a default binding without replacing it.
-- hl.unbind("SUPER + SHIFT + B")

-- Logitech MX Keys examples:
hl.unbind("SUPER + SHIFT + S")
o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
--o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, "omarchy-shell shell toggle omarchy.emojis")
o.bind("SUPER + F7", "Toggle Monitors", "exec ~/.config/hypr/toggle_monitors.sh")
--hl.unbind("SUPER + B")
--o.bind("SUPER + SHIFT + B", "Yandex Browser", "exec env GST_PLUGIN_FEATURE_RANK=vulkan:NONE yandex-browser-stable")
-- 1. Сбрасываем стандартные бинды Omarchy
hl.unbind("SUPER + C")
hl.unbind("SUPER + V")
hl.unbind("SUPER + X")
hl.unbind("CTRL + SUPER + V")
hl.bind("SUPER + code:54", hl.dsp.send_shortcut({ mods = "CTRL", key = "Insert" }))
hl.bind("SUPER + code:55", hl.dsp.send_shortcut({ mods = "SHIFT", key = "Insert" }))
hl.bind("SUPER + code:53", hl.dsp.send_shortcut({ mods = "CTRL", key = "x" }))
hl.bind("SUPER + CTRL + code:55", hl.dsp.exec_cmd("omarchy-launch-walker -m clipboard"))

hl.unbind("SUPER + SHIFT + V")
o.bind("SUPER + SHIFT + V", "VS Code", "exec code")

-- Полностью очищаем старый бинд, привязанный к латинской W
--hl.unbind("SUPER + W")

-- Привязываем физическую клавишу W (сканкод 25) напрямую к закрытию окна
--hl.bind("SUPER + code:24", hl.dsp.window.close())
-- hl.unbind("SUPER + SHIFT + E")
-- o.bind("SUPER + SHIFT + E", "Email", { webapp = "https://gmail.com" })

hl.unbind("SUPER + SHIFT + ALT + B")
o.bind("SUPER + SHIFT + CTRL + B", "Browser (private)", { omarchy = "browser --private" })
-- hl.unbind("SUPER + ALT + SHIFT + F")
-- o.bind("SUPER + CTRL + SHIFT + F", "File manager (cwd)", { omarchy = "nautilus-cwd" })

hl.unbind("SUPER + SHIFT + M")
o.bind("SUPER + SHIFT + M", "Music TUI", { tui = "cliamp", focus = true })

-- Запуск Telegram Desktop по ID приложения
hl.unbind("SUPER + SHIFT + T")
o.bind("SUPER + SHIFT + T", "Telegram", { omarchy = "launch org.telegram.desktop" })

