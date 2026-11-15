-- Hyprland config (Lua, Hyprland 0.55+)
-- Ported from the old hyprland.conf. Wiki: https://wiki.hypr.land/configuring/

----------------
--  MONITORS  --
----------------
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" })
hl.monitor({ output = "HDMI-A-2", disabled = true })

-------------------
--  MY PROGRAMS  --
-------------------
local terminal    = "ghostty"
local fileManager = "dolphin"
local menu        = "rofi -show drun"
local browser     = "~/zen-browser/zen"
local dock        = 'nwg-dock-hyprland -d -hd 150 -i 40 -mb 8 -c "rofi -show drun"'

-----------------
--  AUTOSTART  --
-----------------
hl.on("hyprland.start", function()
    hl.exec_cmd("~/.config/hypr/scripts/wallpaper.sh") -- animated forest (mpvpaper) or still (hyprpaper)
    hl.exec_cmd("waybar")
    hl.exec_cmd(dock)                                  -- bottom dock, shows when mouse hits bottom edge
    hl.exec_cmd(browser)
end)

-----------------------------
--  ENVIRONMENT VARIABLES  --
-----------------------------
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

---------------------
--  LOOK AND FEEL  --  (forest theme)
---------------------
hl.config({
    general = {
        gaps_in     = 5,
        gaps_out    = 20,
        border_size = 2,
        col = {
            active_border   = { colors = { "rgba(a2c56eee)", "rgba(5fa892ee)" }, angle = 45 },
            inactive_border = "rgba(2a3f33aa)",
        },
        resize_on_border = false,
        allow_tearing    = false,
        layout           = "dwindle",
    },

    decoration = {
        rounding       = 10,
        rounding_power = 2,
        active_opacity   = 1.0,
        inactive_opacity = 1.0,
        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = "rgba(050c09ee)",
        },
        blur = {
            enabled        = true,
            size           = 8,
            passes         = 3,
            ignore_opacity = true,
            noise          = 0.01,
            vibrancy       = 0.1696,
        },
    },

    animations = { enabled = false },

    dwindle = {
        preserve_split = true,
    },

    master = { new_status = "master" },

    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo   = true,
        focus_on_activate       = true,
    },

    input = { kb_layout = "us" },
})

-- Animation curves (only used if animations.enabled = true above)
hl.curve("easeOutQuint", { type = "bezier", points = { {0.23, 1},  {0.32, 1} } })
hl.curve("linear",       { type = "bezier", points = { {0, 0},     {1, 1}    } })
hl.curve("almostLinear", { type = "bezier", points = { {0.5, 0.5}, {0.75, 1} } })
hl.curve("quick",        { type = "bezier", points = { {0.15, 0},  {0.1, 1}  } })

-------------
--  INPUT  --
-------------
hl.device({ name = "epic-mouse-v1", sensitivity = -0.5 })
hl.device({ name = "gdx1515:00-27c6:01f4-touchpad", enabled = true })

-------------------
--  KEYBINDINGS  --
-------------------
local mainMod = "SUPER"
local function bind(keys, dsp, opts) hl.bind(mainMod .. " + " .. keys, dsp, opts) end
local exec = hl.dsp.exec_cmd

-- Custom
bind("P",         exec("hyprctl switchxkblayout current next"))
bind("S",         exec("hyprshot -m region --clipboard-only"))
bind("SHIFT + S", exec("hyprshot -m window --clipboard-only"))
bind("SHIFT + D", exec("DEV_ENV=/home/nato/personal/dev ~/personal/dev/dev-env && hyprctl reload"))
bind("K",         exec("wshowkeys -a right -m 50 -l 42 -t 1069"))
bind("SHIFT + K", exec("pkill -9 wshowkeys"))
bind("W",         exec("pkill waybar; waybar"))
bind("TAB",       exec("pkill -35 nwg-dock"))  -- toggle the dock
bind("SHIFT + T", exec("/home/nato/personal/eleven-streamer/build-hyprland && /home/nato/personal/eleven-streamer/run-hyprland"))

-- Apps & windows
bind("Q",         exec(terminal))
bind("C",         hl.dsp.window.close())
bind("SHIFT + M", hl.dsp.exit())
bind("E",         exec(fileManager))
bind("B",         exec(browser))
bind("V",         hl.dsp.window.float({ action = "toggle" }))
bind("D",         exec(menu))
bind("P",         hl.dsp.window.pseudo())
bind("SHIFT + J", hl.dsp.layout("togglesplit"))
bind("F",         hl.dsp.window.fullscreen())
bind("M",         hl.dsp.workspace.move({ monitor = "+1" }))

-- Focus (vim keys)
bind("H", hl.dsp.focus({ direction = "left" }))
bind("L", hl.dsp.focus({ direction = "right" }))
bind("K", hl.dsp.focus({ direction = "up" }))
bind("J", hl.dsp.focus({ direction = "down" }))

-- Workspaces 1-9
for i = 1, 9 do
    bind(tostring(i),             hl.dsp.focus({ workspace = i }))
    bind("SHIFT + " .. i,         hl.dsp.window.move({ workspace = i }))
end

-- Mouse move/resize
bind("mouse:272", hl.dsp.window.drag(),   { mouse = true })
bind("mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Media / brightness
local lr = { locked = true, repeating = true }
hl.bind("XF86AudioRaiseVolume",  exec("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), lr)
hl.bind("XF86AudioLowerVolume",  exec("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      lr)
hl.bind("XF86AudioMute",         exec("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     lr)
hl.bind("XF86AudioMicMute",      exec("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   lr)
hl.bind("XF86MonBrightnessUp",   exec("brightnessctl s 10%+"), lr)
hl.bind("XF86MonBrightnessDown", exec("brightnessctl s 10%-"), lr)
hl.bind("XF86AudioNext",  exec("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", exec("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  exec("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  exec("playerctl previous"),   { locked = true })

------------------------------
--  WINDOWS AND WORKSPACES  --
------------------------------
hl.window_rule({ name = "suppress-maximize", match = { class = ".*" }, suppress_event = "maximize" })
hl.window_rule({
    name  = "fix-xwayland-drags",
    match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
    no_focus = true,
})

-- Smart gaps: no gaps/border/rounding when a workspace has a single window
hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
hl.window_rule({ name = "no-gaps-wtv1", match = { float = false, workspace = "w[tv1]" }, border_size = 0, rounding = 0 })
hl.window_rule({ name = "no-gaps-f1",   match = { float = false, workspace = "f[1]" },  border_size = 0, rounding = 0 })

-- Frosted-glass blur behind the dock, waybar and rofi
hl.layer_rule({
    name  = "glass-layers",
    match = { namespace = "^(nwg-dock|waybar|rofi)$" },
    blur = true,
    ignore_alpha = 0,
})
