from os import path
import json

qtile_path = path.join(path.expanduser("~"), ".config", "qtile")


### LOAD THEME ###
#themes:
#dark-grey
#dracula
#material-darker
#material-ocean
#monokai-pro
#nord-wave
#nord
#onedark
#rosepine

def load_theme():
    theme = "monokai-pro"

    config_theme = path.join(qtile_path, "config.json")
    if path.isfile(config_theme):
        if config_theme != theme:
             with open(config_theme, "w") as f:
                f.write(f'{{"theme": "{theme}"}}\n')
        else:
            with open(config_theme) as f:
                theme = json.load(f)["theme"]
    else:
        with open(config_theme, "w") as f:
            f.write(f'{{"theme": "{theme}"}}\n')

    theme_file = path.join(qtile_path, "themes", f"{theme}.json")
    if not path.isfile(theme_file):
        raise Exception(f'"{theme_file}" does not exist')

    with open(path.join(theme_file)) as f:
        return json.load(f)


if __name__ == "colors":
    color = load_theme()
