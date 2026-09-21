-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- List current monitors and supported resolutions with: hyprctl monitors all

local omarchy_gdk_scale = 1
local omarchy_monitor_scale = 1.25

hl.env("GDK_SCALE", tostring(omarchy_gdk_scale))
-- 1. Отключаем монитор Philips (Передаем пустую строку в mode, а в position — "disable
hl.monitor({ output = "HDMI-A-1", disabled = true })

-- 2. Левый монитор TMN (разрешение и смещение вниз на 110 пикселей)
hl.monitor({ output = "DP-2", mode = "1920x1080@74.97", position = "0x110", scale = 1 })

-- 3. Правый главный ультраширокий Xiaomi (разрешение 165 Гц и позиция сразу за левым)
hl.monitor({ output = "DP-1", mode = "3440x1440@165", position = "1920x0", scale =  omarchy_monitor_scale })


-- Configure a specific monitor.
-- hl.monitor({ output = "DP-2", mode = "2560x1440@144", position = "0x0", scale = 1 })

-- Portrait/rotated secondary monitor (transform: 1 = 90°, 3 = 270°).
-- hl.monitor({ output = "DP-2", mode = "preferred", position = "auto", scale = 1, transform = 1 })
