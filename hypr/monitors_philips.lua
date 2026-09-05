local omarchy_gdk_scale = 1
hl.env("GDK_SCALE", tostring(omarchy_gdk_scale))

-- Включен ТОЛЬКО монитор Philips (задайте его разрешение, например "1920x1080@60")
hl.monitor({ output = "HDMI-A-1", mode = "preferred", position = "0x0", scale = 1 })

-- Выключаем два других монитора
hl.monitor({ output = "DP-2", disabled = true })
hl.monitor({ output = "DP-1", disabled = true })
