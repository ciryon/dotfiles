-- Keep only your personal input overrides here. Settings below replace
-- Omarchy's defaults.

-- Keyboard, mouse and touchpad.
-- See https://wiki.hypr.land/Configuring/Basics/Variables/#input
hl.config({
  input = {
    kb_layout = "us",

    -- compose:caps      -> Caps Lock acts as the Compose key
    -- grp:alt_space_toggle -> Alt+Space cycles keyboard layouts
    kb_options = "compose:caps,grp:alt_space_toggle",

    -- Keyboard type to match Keychron K8 Pro.
    kb_model = "pc105",

    -- Change speed of keyboard repeat.
    repeat_rate = 60,
    repeat_delay = 200,

    -- Start with numlock on by default.
    numlock_by_default = true,

    -- Inverted scrolling on the mouse as well as the touchpad (intentional).
    natural_scroll = true,

    touchpad = {
      natural_scroll = true,

      -- Control the speed of your scrolling.
      scroll_factor = 0.3,

      -- Left-click-and-drag with three fingers.
      drag_3fg = true,
    },
  },

  cursor = {
    no_hardware_cursors = true,
  },
})

-- Four-finger horizontal swipe changes workspace.
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Gestures/
hl.gesture({ fingers = 4, direction = "horizontal", action = "workspace" })

-- Per-device overrides. The Keychron reports under two names depending on
-- which of its interfaces is bound, so both get the same layout options.
-- Append altwin:swap_lalt_lwin here to swap Alt/Super on the Keychron.
hl.device({
  name = "keychron-keychron-k8-pro",
  kb_options = "compose:caps,grp:alt_space_toggle",
})
hl.device({
  name = "keychron-keychron-k8-pro-keyboard",
  kb_options = "compose:caps,grp:alt_space_toggle",
})

-- Apple Magic Trackpad: physical clicks only, no tap-to-click.
hl.device({
  name = "apple-inc.-magic-trackpad",
  tap_to_click = false,
  middle_button_emulation = false,
  clickfinger_behavior = false,
})
hl.device({
  name = "apple-inc.-magic-trackpad-1",
  tap_to_click = false,
  middle_button_emulation = false,
  clickfinger_behavior = false,
})

-- App-specific touchpad scroll speeds.
o.window("(Alacritty|kitty|foot)", { scroll_touchpad = 1.0 })
o.window("com.mitchellh.ghostty", { scroll_touchpad = 0.8 })
