from curses import window
from libqtile.config import Key, Click, Drag, Group, Match, Screen
from libqtile.lazy import lazy
from libqtile import bar, layout, widget


terminal = "kitty"
browser = "brave"
mod = "mod4"

#### Key Defaults #####
keys = [
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(),desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    ## JUST BSP MODE ###
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(), desc="Toggle between split and unsplit sides of stack"),
    ##
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),

    ### MY KEYBINDINGS ###
    Key([mod, "shift"], "c", lazy.spawn("code"), desc="open VSC"),
    Key([mod, "shift"], "b", lazy.spawn(browser), desc="open browser"),
    Key([mod], "m", lazy.window.toggle_maximize(), desc=" Maximize focus window"),
    Key([mod, "control"], "m", lazy.window.toggle_minimize(), desc="Hide focus window"),
    Key([mod, "control"], "b", lazy.hide_show_bar(), desc="Toggle hide - show bar"),
    # Volume
    Key([],"XF86AudioRaiseVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%"), desc="increase vol"),
    Key([], "XF86AudioLowerVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%"), desc="decrese vol"),
    Key([], "XF86AudioMute", lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle"), desc="mute"),
    Key(["Mode_switch"], "f10", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%"), desc="increase vol"),
    Key(["control", "shift"], "b", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%"), desc="decrese vol"),
    # Brightness
    # Key([mod, "control"], "f9", "XF86MonBrightnessUp", "brightnessctl set +10%"),
    # Key([mod, "control"], "f10", "XF86MonBrightnessDown", "brightnessctl set 10%-"),
]


# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]
