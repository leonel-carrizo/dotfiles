from libqtile.config import Group, Key
from libqtile.lazy import lazy
from keybindings import mod, keys

groups = [
    Group(i)
    for i in [
        "   ",
        "   ",
        "   ",
        "   ",
        "   ",
        "   ",
        "   ",
        "   ",
        "   ",
    ]
]

### CREATE GROUPS ###
for i, group in enumerate(groups):
    actual_key = str(i + 1)
    keys.extend(
        [
            # Switch to workspace N
            Key([mod], actual_key, lazy.group[group.name].toscreen()),
            # Send window to workspace N
            Key([mod, "shift"], actual_key, lazy.window.togroup(group.name)),
        ]
    )
