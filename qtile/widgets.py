import subprocess
from libqtile import qtile
from libqtile import widget
from colors import color
import json


def base(fg="text", bg="dark"):
    return {"foreground": color[fg], "background": color[bg]}


def separator():
    return widget.Sep(**base(), linewidth=0, padding=2)


def icon(fg="text", bg="dark", fontsize=15, text="?", mouse_callbacks={}):
    return widget.TextBox(**base(fg, bg), fontsize=fontsize, text=text, padding=5, mouse_callbacks=mouse_callbacks )


def powerline(fg="light", bg="dark"):
    return widget.TextBox(
            **base(fg, bg), text="◢", fontsize=47, padding=0,  # Icon: nf-oct-triangle_left
    )

def workspaces():
    return [
        widget.GroupBox(
            **base(fg="light"),
            font="IosevkaNerdFont",
            fontsize=16,
            margin_y=3,
            margin_x=0,
            padding_y=5,
            padding_x=1,
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
        widget.Spacer(background=color["dark"], length=90),
        widget.WindowName(**base(fg="active"), fontsize=14, padding=5, max_chars=40),
    ]

## for read the ethernet interface in use ## 
get_interface = "ip route get 8.8.8.8 | grep -oP 'dev \K\w+'"
run_interface = subprocess.run(get_interface, shell=True, stdout=subprocess.PIPE)
interface = run_interface.stdout.decode().strip()


primary_widgets = [
    *workspaces(),
    widget.Prompt(),
    ## UPDATES ## 
    powerline("color4", "dark"),
    icon(bg="color4", text="  ", mouse_callbacks={"Button1": lambda : qtile.spawn("kitty" + " -e sudo pacman -Syu")}),  # Icon: nf-fa-download
    widget.CheckUpdates(
        background=color["color4"],
        colour_have_updates=color["text"],
        colour_no_updates=color["text"],
        no_update_string="0",
        display_format="Updates:{updates}",
        update_interval=1800,
        distro="Arch",
        #custom_command="pacman -Qu",
        mouse_callbacks={
            "Button1": lambda: qtile.spawn("kitty" + " -e sudo pacman -Syu")
        },
    ),
    ## MEMORY RAM ## 
    powerline("color2", "color4"),
    icon(bg="color2",fontsize=20, text=" 󰍛"),  # Icon: nf-md-memory
    widget.Memory(**base(bg="color2")),
    ## WIFI ## 
    powerline("color3", "color2"),
    icon(bg="color3", text=" ", mouse_callbacks={"Button1": lambda: qtile.spawn("kitty" + " -e nmtui")}),  # Icon: nf-fa-feed
    widget.Net(**base(bg="color3"), interface=interface, prefix="M"),
    ## LAYOUT ## 
    powerline("color2", "color3"),
    widget.CurrentLayoutIcon(**base(fg="dark",bg="color2"), scale=0.80),
    widget.CurrentLayout(**base(bg="color2")),
    ## Calendar, TIME ## 
    powerline("color1", "color2"),
    icon(bg="color1", fontsize=15, text="📅"),  # Icon: nf-mdi-calendar_clock
    widget.Clock(**base(bg="color1"), format="%d/%m/%Y - %H:%M "),
    ## VOLUME ## 
    powerline("active", "color1"),
    icon(
        bg="active", 
        fontsize=15, 
        text="🔊", 
        mouse_callbacks={"Button1":lambda: qtile.spawn("pavucontrol")}
        ),
    widget.PulseVolume(
        foreground=color["dark"], 
        background=color["active"],
        fmt="{}",
        update_interval=0.1,
    ),
    ##BLUETOOTH
    icon(
        bg="active",
        text=" ",
        mouse_callbacks={"Button1":lambda: qtile.spawn("blueman-manager")}
        ),
    widget.Bluetooth(fmt="{}"),
    ##BATTERY
    powerline("color3", "active"),
    #widget.BatteryIcon(scale=0.90, update_interval=1, background=color["color3"]),
    widget.Battery(
        **base(bg="color3"),
        update_interval=1,
        fmt="{}",
        charge_char="󰂄 ",
        discharge_char="󱊣 ",
        full_char="󰁹 ",
        empty_char="󱉞 ",
        format=" {char} {percent:2.0%} ",
        #low_background="FF0000",
        notification_timeout=15,
        notification_below=5,
    )
]

secondary_widgets = [
    *workspaces(),
    separator(),
    powerline("color1", "dark"),
    widget.CurrentLayoutIcon(**base(bg="color1"), scale=0.60),
    widget.CurrentLayout(**base(bg="color1"), padding=5),
    powerline("color2", "color1"),
    widget.Clock(**base(bg="color2"), format="%d/%m/%Y - %H:%M "),
]


widget_defaults = {
    "font": "HackNerdFont",
    "fontsize": 14,
    "padding": 3,
}
extension_defaults = widget_defaults.copy()
