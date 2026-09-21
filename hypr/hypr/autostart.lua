-- Extra autostart processes.
--o.launch_on_start("my-service")
--o.launch_on_start("systemd-inhibit --what=idle pcloud")

-- AmneziaVPN autostart: запускаем, ждём, перемещаем на scratchpad
-- o.launch_on_start("sleep 4 && AmneziaVPN")
--o.launch_on_start("sleep 10 && hyprctl dispatch movetoworkspacesilent special class:AmneziaVPN")
-- Загружаем raw-правила для оверлея
