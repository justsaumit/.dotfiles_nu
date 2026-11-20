-- Hyprland Lua config — migrated from hyprland.conf
-- Original .conf kept as reference at hyprland.conf (no longer loaded by 0.57+)

--------------------
---- MONITORS ----
--------------------

hl.monitor({
    output    = "eDP-1",
    mode      = "1920x1080@144",
    position  = "0x0",
    scale     = 1.0,
    transform = 0,
})
hl.monitor({
    output    = "HDMI-A-1",
    mode      = "1920x1080@144",
    position  = "0x0",
    scale     = 1.0,
    transform = 0,
    mirror    = "eDP-1",
})


-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("dunst")
    hl.exec_cmd("wpaperd")
    hl.exec_cmd("suspend.sh")
    hl.exec_cmd("nm-applet")
    hl.exec_cmd("blueman-applet")
    hl.exec_cmd("notion-app")
    hl.exec_cmd("memospot")
    hl.exec_cmd("systemctl --user import-environment DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("xhost +SI:localuser:root")
end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE",         "24")
hl.env("HYPRCURSOR_SIZE",      "24")
hl.env("XDG_SESSION_TYPE",     "wayland")
hl.env("WLR_NO_HARDWARE_CURSORS", "1")
hl.env("WLR_DRM_NO_MODIFIERS", "1")
hl.env("WLR_RENDERER",         "vulkan")


-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 20,

        border_size = 2,

        col = {
            active_border   = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },

        resize_on_border = false,
        allow_tearing    = false,
        layout           = "master",
    },

    decoration = {
        rounding          = 3,
        active_opacity    = 0.99,
        inactive_opacity  = 0.94,
        fullscreen_opacity = 1.0,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = "rgba(1a1a1aee)",
        },

        blur = {
            enabled  = true,
            size     = 4,
            passes   = 1,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },

    master = {
        special_scale_factor = 0.8,
        new_on_top           = false,
        orientation          = "left",
    },

    binds = {
        workspace_back_and_forth = true,
        allow_workspace_cycles   = true,
    },
})


--------------------
---- ANIMATIONS ----
--------------------

hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })

hl.animation({ leaf = "windows",     enabled = true, speed = 7,  bezier = "myBezier" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 7,  bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border",      enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 8,  bezier = "default" })
hl.animation({ leaf = "fade",        enabled = true, speed = 7,  bezier = "default" })
hl.animation({ leaf = "workspaces",  enabled = true, speed = 6,  bezier = "default" })


---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "caps:escape",
        kb_rules   = "",

        follow_mouse  = 1,
        sensitivity   = 0,
        scroll_factor = 1.0,
        scroll_method = "2fg",

        touchpad = {
            natural_scroll        = true,
            scroll_factor         = 1.0,
            tap_to_click          = true,
            tap_and_drag          = true,
            disable_while_typing  = false,
            clickfinger_behavior  = true,
        },
    },
})

-- Touch gestures
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 3, direction = "down", action = {
    finish = function() hl.dispatch(hl.dsp.window.move({ workspace = "special" })) end
}})
hl.gesture({ fingers = 3, direction = "up", action = {
    finish = function() hl.dispatch(hl.dsp.window.move({ workspace = "e+0" })) end
}})
hl.gesture({ fingers = 3, direction = "pinch",      action = "fullscreen" })

-- Per-device touchpad config
hl.device({
    name                   = "pnp0c50:0d-06cb:cebd-touchpad",
    enabled                = true,
    accel_profile          = "flat",
    tap_to_click           = true,
    tap_and_drag           = true,
    drag_lock              = true,
    middle_button_emulation = false,
})


---------------------
---- KEYBINDINGS ----
---------------------

local MOD = "SUPER"

-- Trigger swaylock on lid close
hl.bind("switch:on:Lid Switch", hl.dsp.exec_cmd("~/.scripts/swaylock-wrapper"), { locked = true })

-- Core WM
hl.bind(MOD .. " + SHIFT + Return", hl.dsp.exec_cmd("foot"))
hl.bind(MOD .. " + W",              hl.dsp.window.close())
hl.bind(MOD .. " + CTRL + SHIFT + Q", hl.dsp.exit())
hl.bind(MOD .. " + F",              hl.dsp.window.float({ action = "toggle" }))
hl.bind(MOD .. " + Space",          hl.dsp.window.float({ action = "toggle" }))
hl.bind(MOD .. " + P",              hl.dsp.window.pin())
hl.bind(MOD .. " + SHIFT + S",      hl.dsp.window.move({ workspace = "special" }))
hl.bind(MOD .. " + S",              hl.dsp.workspace.toggle_special())
hl.bind(MOD .. " + F1",             hl.dsp.exec_cmd("pidkillall"))

-- Rofi / launchers (release binds)
hl.bind(MOD .. " + D",              hl.dsp.exec_cmd("pkill rofi || rofi -show run"),  { release = true })
hl.bind(MOD .. " + CTRL + D",       hl.dsp.exec_cmd("pkill rofi || rofi -show drun"), { release = true })
hl.bind(MOD .. " + F3",             hl.dsp.exec_cmd("rofi -modi emoji -show emoji -kb-custom-1 Ctrl+C"))
hl.bind(MOD .. " + X",              hl.dsp.exec_cmd("cliphist list | rofi -dmenu | cliphist decode | wl-copy"))
hl.bind("ALT + L",                  hl.dsp.exec_cmd("~/.scripts/rofi-beats-linux.sh"))
hl.bind(MOD .. " + ALT + M",        hl.dsp.exec_cmd("toggle-touchpad-hypr"))

-- Applications
hl.bind(MOD .. " + Q",              hl.dsp.exec_cmd("brave"))
hl.bind(MOD .. " + CTRL + Q",       hl.dsp.exec_cmd("brave --incognito"))
hl.bind(MOD .. " + SHIFT + Z",      hl.dsp.exec_cmd("zen-browser"))
hl.bind(MOD .. " + SHIFT + W",      hl.dsp.exec_cmd("whatsapp-nativefier --no-sandbox"))
hl.bind(MOD .. " + SHIFT + N",      hl.dsp.exec_cmd("zen-browser https://ncloud.draconyan.xyz"))
hl.bind(MOD .. " + CTRL + E",       hl.dsp.exec_cmd("emacs"))
hl.bind(MOD .. " + SHIFT + E",      hl.dsp.exec_cmd("thunderbird"))
hl.bind(MOD .. " + ALT + H",        hl.dsp.exec_cmd("zen-browser https://habitica.com"))
hl.bind(MOD .. " + ALT + E",        hl.dsp.exec_cmd("zen-browser https://mail.proton.me/u/0/inbox"))
hl.bind(MOD .. " + T",              hl.dsp.exec_cmd("tessen"))
hl.bind(MOD .. " + SHIFT + M",      hl.dsp.exec_cmd("spotify"))
hl.bind(MOD .. " + CTRL + M",       hl.dsp.exec_cmd("memospot"))
hl.bind(MOD .. " + SHIFT + D",      hl.dsp.exec_cmd("webcord --enable-features=UseOzonePlatform --ozone-platform=wayland"))
hl.bind(MOD .. " + CTRL + T",       hl.dsp.exec_cmd("telegram-desktop"))
hl.bind(MOD .. " + R",              hl.dsp.exec_cmd("foot --term xterm-256color -e ranger"))
hl.bind(MOD .. " + SHIFT + P",      hl.dsp.exec_cmd("foot -e pulsemixer"))
hl.bind(MOD .. " + SHIFT + G",      hl.dsp.exec_cmd("foot --term xterm -e gotop"))
hl.bind(MOD .. " + SHIFT + H",      hl.dsp.exec_cmd("foot -e htop"))
hl.bind(MOD .. " + SHIFT + B",      hl.dsp.exec_cmd("foot -e btop"))
hl.bind(MOD .. " + F9",             hl.dsp.exec_cmd("blueman-manager"))

-- Screenlock
hl.bind(MOD .. " + L",              hl.dsp.exec_cmd("~/.scripts/swaylock-wrapper"))

-- Screenshots
local SS_DIR = "/home/justsaumit/pix/Screenshots"
local function ss_full()
    return 'IMG="' .. SS_DIR .. '/pic-full-$(date +%y-%m-%d--%H-%M-%S).png" && grimblast save output "$IMG" && wl-copy < "$IMG" && dunstify "Full screenshot" "$(basename $IMG)" -t 1500'
end
local function ss_sel()
    return 'IMG="' .. SS_DIR .. '/pic-sel-$(date +%y-%m-%d--%H-%M-%S).png" && grimblast save area "$IMG" && wl-copy < "$IMG" && dunstify "Region screenshot" "$(basename $IMG)" -t 1500'
end

hl.bind("Print",       hl.dsp.exec_cmd(ss_full()))
hl.bind("F10",         hl.dsp.exec_cmd(ss_full()))
hl.bind("CTRL + Print",hl.dsp.exec_cmd(ss_sel()))
hl.bind("F11",         hl.dsp.exec_cmd(ss_sel()))
hl.bind("ALT + Print", hl.dsp.exec_cmd("grimblast save area - | satty -f -"))
hl.bind("F12",         hl.dsp.exec_cmd("grimblast save area - | satty -f -"))

-- Media / volume keys
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd('[[ "$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep MUTE)" ]] && dunstify "Mute" "Volume set to 0%" -i volume-xmark -t 1000 -r 1234; wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle'), { locked = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd('wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+ && dunstify "Volume Changed" "Volume set to $(volumecurr)" -i volume-high -t 1500 -r 1235'), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd('wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%- && dunstify "Volume Changed" "Volume set to $(volumecurr)" -i volume-low -t 1500 -r 1236'),  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd('brillo -A 4 && dunstify -u normal -t 3000 -r 90210 -i brightness "$(printf %.0f%% $(brillo -G))"'), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd('brillo -U 4 && dunstify -u normal -t 3000 -r 90210 -i brightness "$(printf %.0f%% $(brillo -G))"'), { locked = true, repeating = true })

hl.bind("F2",             hl.dsp.exec_cmd('rofi -show calc -modi calc -no-show-match -no-sort -calc-command "echo -n \'{result}\' | wl-copy"'))
hl.bind("XF86Calculator", hl.dsp.exec_cmd('rofi -show calc -modi calc -no-show-match -no-sort -calc-command "echo -n \'{result}\' | wl-copy"'))

hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("if playerctl -p spotify status > /dev/null 2>&1; then playerctl -p spotify play-pause; else playerctl -p chromium play-pause; fi"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("if playerctl -p spotify status > /dev/null 2>&1; then playerctl -p spotify previous; else playerctl -p chromium previous; fi"),    { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("if playerctl -p spotify status > /dev/null 2>&1; then playerctl -p spotify next; else playerctl -p chromium next; fi"),            { locked = true })

-- Master layout
hl.bind(MOD .. " + Return", hl.dsp.layout("swapwithmaster"))
hl.bind(MOD .. " + U",      hl.dsp.window.fullscreen())
hl.bind(MOD .. " + K",      hl.dsp.layout("cycleprev"))
hl.bind(MOD .. " + J",      hl.dsp.layout("cyclenext"))

-- Workspaces
for i = 1, 9 do
    hl.bind(MOD .. " + " .. i,             hl.dsp.focus({ workspace = i }))
    hl.bind(MOD .. " + SHIFT + " .. i,     hl.dsp.window.move({ workspace = i }))
end
hl.bind(MOD .. " + 0",             hl.dsp.focus({ workspace = 10 }))
hl.bind(MOD .. " + SHIFT + 0",     hl.dsp.window.move({ workspace = 10 }))
hl.bind(MOD .. " + TAB",           hl.dsp.focus({ workspace = "previous" }))
hl.bind("ALT + tab",               hl.dsp.focus({ workspace = "e+1" }))
hl.bind("ALT + SHIFT + tab",       hl.dsp.focus({ workspace = "e-1" }))
hl.bind(MOD .. " + mouse_down",    hl.dsp.focus({ workspace = "e+1" }))
hl.bind(MOD .. " + mouse_up",      hl.dsp.focus({ workspace = "e-1" }))
hl.bind("mouse:276",               hl.dsp.focus({ workspace = "e+1" }))
hl.bind("mouse:275",               hl.dsp.focus({ workspace = "e-1" }))

-- Mouse window control
hl.bind(MOD .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(MOD .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Resize submap (ALT+R enters, ESC exits)
hl.define_submap("resize", function()
    hl.bind(MOD .. " + H", hl.dsp.window.resize({ x = -10, y = 0,   relative = true }), { repeating = true })
    hl.bind(MOD .. " + L", hl.dsp.window.resize({ x = 10,  y = 0,   relative = true }), { repeating = true })
    hl.bind(MOD .. " + K", hl.dsp.window.resize({ x = 0,   y = -10, relative = true }), { repeating = true })
    hl.bind(MOD .. " + J", hl.dsp.window.resize({ x = 0,   y = 10,  relative = true }), { repeating = true })
    hl.bind("escape",       hl.dsp.submap("reset"))
end)
hl.bind("ALT + R", hl.dsp.submap("resize"))


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- Suppress maximize events
hl.window_rule({
    name           = "suppress-maximize-events",
    match          = { class = ".*" },
    suppress_event = "maximize",
})

-- Fix XWayland drag issues (defined twice in .conf — once is enough)
hl.window_rule({
    name       = "fix-xwayland-drags",
    match      = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
    no_focus   = true,
})

-- Hyprland-run float
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },
    move  = "20 monitor_h-120",
    float = true,
})

-- Spotify to workspace 9
hl.window_rule({
    match     = { class = "^(Spotify)$" },
    workspace = 9,
})

-- Force opacity 1.0 for specific apps (overrides global inactive opacity)
-- opacity string format: "active inactive"
for _, cls in ipairs({ "obsidian", "code", "brave", "mpv", "zen" }) do
    hl.window_rule({
        match   = { class = "^(" .. cls .. ")$" },
        opacity = "1.0 1.0",
    })
end

-- xwaylandvideobridge fixes
hl.window_rule({
    name             = "xwayland-video-bridge-fixes",
    match            = { class = "xwaylandvideobridge" },
    no_initial_focus = true,
    no_focus         = true,
    no_anim          = true,
    no_blur          = true,
    max_size         = { 1, 1 },
    opacity          = 0.0,
})

-- Smart gaps (no gaps when only one window)
hl.workspace_rule({ workspace = "w[t1]",  gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "w[tg1]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })

hl.window_rule({ match = { float = false, workspace = "w[t1]"  }, border_size = 0, rounding = 0 })
hl.window_rule({ match = { float = false, workspace = "w[tg1]" }, border_size = 0, rounding = 0 })
hl.window_rule({ match = { float = false, workspace = "f[1]"   }, border_size = 0, rounding = 0 })
