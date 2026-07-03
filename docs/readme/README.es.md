# Good Arch Setting

[![English](https://img.shields.io/badge/lang-English-blue)](../../README.md)
[![中文](https://img.shields.io/badge/lang-%E4%B8%AD%E6%96%87-red)](README.zh-CN.md)
[![Español](https://img.shields.io/badge/lang-Espa%C3%B1ol-yellow)](README.es.md)
[![日本語](https://img.shields.io/badge/lang-%E6%97%A5%E6%9C%AC%E8%AA%9E-green)](README.ja.md)

Dotfiles personales para Arch Linux, orientados a una estación de trabajo Wayland basada en Niri.

El objetivo de este repositorio es hacer que una instalación limpia de Arch se sienta familiar rápidamente: instala las listas de paquetes, despliega los módulos con Stow y entra en la sesión Wayland.

## Stack actual

El estado actual del repositorio se basa en estos componentes:

| Área                                 | Componentes                                                               |
| ------------------------------------ | ------------------------------------------------------------------------- |
| Sesión Wayland                       | Niri, UWSM, SDDM                                                          |
| Barra y entorno de escritorio        | Waybar, Fuzzel, Foot, Mako, Awww, Wlsunset                                |
| Bloqueo e inactividad                | Hyprlock, Swayidle                                                        |
| Audio y base para compartir pantalla | PipeWire, WirePlumber, Pavucontrol, xdg-desktop-portal-gtk                |
| Método de entrada                    | Fcitx5 + Rime                                                             |
| Editor                               | Neovim / LazyVim                                                          |
| Shell                                | Zsh + Zim, Fzf, Zoxide, Eza                                               |
| Flujo de archivos y documentos       | Yazi, Thunar, Zathura, Imv, Mpv                                           |
| Listas de paquetes                   | `pac.txt` para paquetes oficiales de Arch, `aur.txt` para paquetes de AUR |

Las menciones antiguas a Hyprland, Alacritty, Kitty o Fish no forman parte de la configuración actual, salvo que se vuelvan a añadir sus directorios de configuración.

## Estructura del repositorio

```txt
.
├── aur.txt                         # Lista de paquetes AUR
├── pac.txt                         # Lista de paquetes oficiales de Arch
├── hyprlock/.config/hypr/          # Configuración de Hyprlock
├── mako/.config/mako/              # Configuración del demonio de notificaciones
├── niri/.config/niri/              # Configuración de Niri
├── nvim/.config/nvim/              # Configuración de Neovim/LazyVim
├── rime/.local/share/fcitx5/rime/  # Diccionarios y esquemas de Fcitx5 Rime
├── waybar/.config/waybar/          # Configuración, estilo y menú de energía de Waybar
├── yazi/.config/yazi/              # Configuración de Yazi
├── zathura/.config/zathura/        # Configuración de Zathura
├── zim/.zimrc                      # Lista de módulos de Zim
└── zsh/.zshrc                      # Configuración de Zsh
```

## Instalación de paquetes

Instala los paquetes oficiales:

```bash
sudo pacman -Syu --needed - < pac.txt
```

Para instalar paquetes de AUR, primero necesitas un helper de AUR. `aur.txt` incluye `paru`, así que instálalo manualmente si el sistema aún no lo tiene:

```bash
git clone https://aur.archlinux.org/paru.git /tmp/paru
cd /tmp/paru
makepkg -si
```

Luego instala la lista de AUR:

```bash
paru -S --needed - < aur.txt
```

## Despliegue de dotfiles

El repositorio está organizado para GNU Stow. Desde la raíz del repositorio, despliega solo los módulos que necesites:

```bash
stow niri waybar mako hyprlock yazi zathura zsh zim nvim rime
```

Antes de usar Stow, haz copia de seguridad de las configuraciones existentes que puedan entrar en conflicto:

```bash
mv ~/.config/niri ~/.config/niri.bak 2>/dev/null || true
mv ~/.config/waybar ~/.config/waybar.bak 2>/dev/null || true
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null || true
mv ~/.local/share/fcitx5/rime ~/.local/share/fcitx5/rime.bak 2>/dev/null || true
```

## Comportamiento de la sesión

`niri/.config/niri/config.kdl` inicia los servicios principales del escritorio:

```txt
waybar
awww-daemon
mako
wlsunset
foot --server
polkit-gnome-authentication-agent-1
```

Atajos importantes de la configuración actual de Niri:

| Tecla                      | Acción                             |
| -------------------------- | ---------------------------------- |
| `Ctrl+Alt+T`               | Abrir `footclient`                 |
| `Mod+D`                    | Abrir Fuzzel                       |
| `Mod+E`                    | Abrir Yazi dentro de Foot          |
| `Super+Alt+L`              | Bloquear con Hyprlock              |
| `Mod+B`                    | Mostrar u ocultar Waybar           |
| `XF86MonBrightnessUp/Down` | Ajustar brillo con `brightnessctl` |
| `Print`                    | Captura de pantalla de Niri        |

## Notas sobre Waybar

`waybar/.config/waybar/config.jsonc` incluye:

- Módulos de espacios de trabajo y ventanas de Niri.
- Visualización de volumen Pulseaudio/PipeWire con `pavucontrol` al hacer clic.
- Red, batería, temperatura, brillo, reloj, bandeja y menú de energía personalizado.
- Módulo `power-profiles-daemon`.

`pac.txt` usa actualmente:

```txt
tlp
tlp-rdw
tlp-pd
```

`tlp-pd` proporciona `power-profiles-daemon`, así que el módulo de perfiles de energía de Waybar puede funcionar sin instalar el paquete independiente `power-profiles-daemon`. No instales `power-profiles-daemon` junto con `tlp-pd`; entran en conflicto.

## Método de entrada

La configuración de Rime está en:

```txt
rime/.local/share/fcitx5/rime/
```

La lista de paquetes incluye el stack Fcitx5/Rime:

```txt
fcitx5
fcitx5-chinese-addons
fcitx5-configtool
fcitx5-gtk
fcitx5-qt
fcitx5-rime
```

Después de desplegar el módulo de Rime, reinicia Fcitx5 o vuelve a desplegar los esquemas desde la interfaz de Fcitx5.

## Notas sobre Neovim y Yazi

La configuración de Neovim está en:

```txt
nvim/.config/nvim/
```

Paquetes útiles conservados para este flujo de trabajo:

```txt
neovim
ripgrep
fd
lazygit
luarocks
imagemagick
chafa
```

La configuración de Yazi es mínima y usa Neovim como editor bloqueante:

```toml
[opener]
edit = [
  { run = 'nvim "$@"', block = true }
]
```

Atajos de búsqueda predeterminados de Yazi que conviene recordar:

| Tecla | Tipo de búsqueda                 | Backend                |
| ----- | -------------------------------- | ---------------------- |
| `s`   | Búsqueda por nombre de archivo   | `fd`                   |
| `S`   | Búsqueda por contenido           | `ripgrep` / `rg`       |
| `/`   | Buscar dentro de la lista actual | Find interno de Yazi   |
| `f`   | Filtrar la lista actual          | Filtro interno de Yazi |

## Fuentes y recursos visuales

La lista de paquetes actual incluye:

```txt
noto-fonts
noto-fonts-cjk
noto-fonts-emoji
otf-font-awesome
otf-monaspace-nerd
ttf-dejavu
```

Hyprlock usa `MonaspiceNe Nerd Font Mono`, cubierto por `otf-monaspace-nerd`.

Mako también reproduce un sonido de notificación de `ocean-sound-theme`, incluido en `pac.txt`.

## Notas de hardware

`pac.txt` está orientado actualmente a Intel:

```txt
intel-ucode
intel-media-driver
vulkan-intel
```

Para máquinas AMD o Nvidia, reemplaza o amplía los paquetes de hardware según sea necesario. Evita mezclar paquetes específicos de hardware en la base compartida si no todos los equipos objetivo los necesitan.

## Actualizar las listas de paquetes

Paquetes oficiales:

```bash
pacman -Qqen > pac.txt
```

Paquetes AUR:

```bash
pacman -Qqem > aur.txt
```

Advertencia: `pacman -Qqen` solo exporta paquetes oficiales instalados explícitamente. Si una herramienta se instaló solo como dependencia pero es necesaria para este flujo de dotfiles, añádela manualmente a `pac.txt` o márcala como explícita:

```bash
sudo pacman -D --asexplicit ripgrep
```

## Licencia

MIT. Si el repositorio contiene un archivo `LICENSE`, ese archivo tiene prioridad.
