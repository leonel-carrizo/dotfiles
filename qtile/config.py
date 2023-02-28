import os
import subprocess
from libqtile import hook
from keybindings import mod, keys, mouse
from groups import groups
from layouts import layouts, floating_layout
from widgets import extension_defaults, widget_defaults
from screens import screens


@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser("~/.config/qtile/autostart.sh")
    subprocess.Popen([home])


main = None
dgroups_key_binder = None
dgroups_app_rules = []
follow_mouse_focus = True
bring_front_click = False
cursor_warp = True
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
auto_minimize = True
wmname = "LG3D"
