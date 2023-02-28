from libqtile import qtile
from libqtile import widget
from colors import color
import json


def base(fg="text", bg="dark"):
    return {"foreground": color[fg], "background": color[bg]}


def separator():
    return widget.Sep(**base(), linewidth=0, padding=5)


def icon(fg="text", bg="dark", fontsize=16, text="?"):
    return widget.TextBox(**base(fg, bg), fontsize=fontsize, text=text, padding=10)


def powerline(fg="light", bg="dark"):
    return widget.TextBox(
        **base(fg, bg), text="", fontsize=31, padding=-4  # Icon: nf-oct-triangle_left
    )


def workspaces():
    return [
        # separator(),
        widget.GroupBox(
            **base(fg="light"),
            font="HackNerdFont",
            fontsize=19,
            margin_y=3,
            margin_x=0,
            padding_y=8,
            padding_x=5,
            borderwidth=1,
            active=color["active"],
            inactive=color["inactive"],
            rounded=False,
            highlight_method="block",
            urgent_alert_method="block",
            urgent_border=color["urgent"],
            this_current_screen_border=color["focus"],
            this_screen_border=color["grey"],
            other_current_screen_border=color["dark"],
            other_screen_border=color["dark"],
            disable_drag=True
        ),
        widget.Spacer(background=color["dark"], length=200),
        separator(),
        widget.WindowName(**base(fg="active"), fontsize=14, padding=5),
    ]


primary_widgets = [
    *workspaces(),
    separator(),
    widget.Prompt(),
    powerline("color4", "dark"),
    icon(bg="color4", text="  "),  # Icon: nf-fa-download
    widget.CheckUpdates(
        background=color["color4"],
        colour_have_updates=color["text"],
        colour_no_updates=color["text"],
        no_update_string="0",
        display_format="{updates}",
        update_interval=1800,
        custom_command="pacman -Qu",
        mouse_callbacks={
            "Button1": lambda: qtile.cmd_spawn("kitty" + " -e sudo pacman -Syu")
        },
    ),
    powerline("color2", "color4"),
    icon(bg="color2", text=" 󰍛"),  # Icon: nf-md-memory
    widget.Memory(**base(bg="color2")),
    powerline("color3", "color2"),
    icon(bg="color3", text=" "),  # Icon: nf-fa-feed
    widget.Net(**base(bg="color3"), interface="enp0s3"),
    powerline("color2", "color3"),
    widget.CurrentLayoutIcon(**base(bg="color2"), scale=0.70),
    widget.CurrentLayout(**base(bg="color2"), padding=5),
    powerline("color1", "color2"),
    icon(bg="color1", fontsize=17, text=" "),  # Icon: nf-mdi-calendar_clock
    widget.Clock(**base(bg="color1"), format="%d/%m/%Y - %H:%M "),
    powerline("dark", "color1"),
    widget.Systray(background=color["dark"], padding=5),
    #powerline("active", "dark"),
    # widget.Volume(foreground=color["dark"], background=color["active"],fmt="Vol: {}", padding=5,),
]

secondary_widgets = [
    *workspaces(),
    separator(),
    powerline("color1", "dark"),
    widget.CurrentLayoutIcon(**base(bg="color1"), scale=0.65),
    widget.CurrentLayout(**base(bg="color1"), padding=5),
    powerline("color2", "color1"),
    widget.Clock(**base(bg="color2"), format="%d/%m/%Y - %H:%M "),
    powerline("dark", "color2"),
]


widget_defaults = {
    "font": "UbuntuMono Nerd Font Bold",
    "fontsize": 14,
    "padding": 3,
}
extension_defaults = widget_defaults.copy()
