import subprocess
from libqtile.log_utils import logger
from libqtile.config import Screen
from libqtile import bar
from widgets import primary_widgets, secondary_widgets


def init_screens(widgets):
    return bar.Bar(
        widgets,
        20,
        opacity=1.0,
    )


screens = [Screen(top=init_screens(primary_widgets))]

### VERIFICACIÓN DE PANTALLAS CONETADAS ###
#  Variable para almacenar la consulta de contar el número de pantallas conectadas.(Bash)
xrandr = "xrandr | grep -w 'connected' | cut -d ' ' -f 2 | wc -l"
# Ejecuta la consulta en la consola de la variable xrandr arriba.
command = subprocess.run(
    xrandr,
    shell=True,
    stdout=subprocess.PIPE,
    stderr=subprocess.PIPE,
)
if command.returncode != 0:  # verifica que el comando se ejecuto correctamente.
    error = command.stderr.decode("UTF-8")  # Almacena el mensaje en error.
    logger.error(
        f"Failed counting monitors using {xrandr}:\n{error}"
    )  # Registro del error.
    connected_monitors = 1  # Asigna el valor a 1 monitor conectado.
else:  #
    connected_monitors = int(
        command.stdout.decode("UTF-8")
    )  # Si el comando se ejecuta, almacena el numero de monitores conectados.
# Cuando sea más de 1 monitor conectado lo agrega a la lista de pantallas (screens)
if connected_monitors > 1:
    for _ in range(1, connected_monitors):
        screens.append(Screen(top=init_screens(secondary_widgets)))
