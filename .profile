# ~/.profile

# 1. Rutas locales (prioridad máxima para scripts propios y herramientas suckless)
export PATH="$HOME/.local/bin:$HOME/bin"

# 2. Rutas del ecosistema /opt (detectadas en la raíz del sistema)
export PATH="$PATH:/opt/bin:/opt/sbin"

# 3. Rutas estándar del sistema (binarios de usuario y superusuario)
export PATH="$PATH:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin"

export ENV=$HOME/.okshrc
export EDITOR=vim
export VISUAL=vim
export LANG="es_CL.UTF-8"
export TERM="foot"

#export XDG_CONFIG_HOME="$HOME/.config"
#export XDG_CACHE_HOME="$HOME/.cache"
#export XDG_DATA_HOME="$HOME/.local/share"
#export XDG_STATE_HOME="$HOME/.local/state"
export XDG_DATA_DIRS="/home/affe/.local/share:${XDG_DATA_DIRS:-/usr/local/share:/usr/share}"

# 1. Crear y exportar XDG_RUNTIME_DIR de forma segura
if [ -z "${XDG_RUNTIME_DIR}" ]; then
    export XDG_RUNTIME_DIR="/tmp/$(id -u)-runtime-dir"
    if [ ! -d "${XDG_RUNTIME_DIR}" ]; then
        mkdir -p "${XDG_RUNTIME_DIR}"
        chmod 0700 "${XDG_RUNTIME_DIR}"
    fi
fi

# Variables opcionales pero muy recomendadas para Wayland / River
#problemas
export MOZ_ENABLE_WAYLAND=0
export GDK_BACKEND="x11"
########

export XDG_SESSION_TYPE=wayland
export XDG_CURRENT_DESKTOP=river
export QT_QPA_PLATFORM="wayland;xcb"
export SDL_VIDEODRIVER="wayland"
export CLUTTER_BACKEND="wayland"
export _JAVA_AWT_WM_NONREPARENTING=1


# 2. Autoinicio de River solo si estás en la TTY1
if [ -z "${WAYLAND_DISPLAY}" ] && [ "$(tty)" = "/dev/tty1" ]; then
    # Se usa 'exec' para que river reemplace la shell actual.
    # Así, cuando cierres river, se cerrará tu sesión automáticamente.
    exec river-classic
fi
