# Good Arch Setting

[![English](https://img.shields.io/badge/lang-English-blue)](README.md)
[![中文](https://img.shields.io/badge/lang-%E4%B8%AD%E6%96%87-red)](docs/readme/README.zh-CN.md)
[![Español](https://img.shields.io/badge/lang-Espa%C3%B1ol-yellow)](docs/readme/README.es.md)
[![日本語](https://img.shields.io/badge/lang-%E6%97%A5%E6%9C%AC%E8%AA%9E-green)](docs/readme/README.ja.md)

Personal Arch Linux dotfiles for a Niri-based Wayland workstation.

This repository is meant to make a fresh Arch install feel familiar quickly: install the package lists, stow the selected modules, then log into the Wayland session.

## Current stack

The current repository state is based on these components:

| Area                            | Components                                                       |
| ------------------------------- | ---------------------------------------------------------------- |
| Wayland session                 | Niri, UWSM, SDDM                                                 |
| Bar and desktop shell           | Waybar, Fuzzel, Foot, Mako, Awww, Wlsunset                       |
| Lock and idle                   | Hyprlock, Swayidle                                               |
| Audio and screen sharing basics | PipeWire, WirePlumber, Pavucontrol, xdg-desktop-portal-gtk       |
| Input method                    | Fcitx5 + Rime                                                    |
| Editor                          | Neovim / LazyVim                                                 |
| Shell                           | Zsh + Zim, Fzf, Zoxide, Eza                                      |
| File and document workflow      | Yazi, Thunar, Zathura, Imv, Mpv                                  |
| Package lists                   | `pac.txt` for official Arch packages, `aur.txt` for AUR packages |

Old README references to Hyprland, Alacritty, Kitty, or Fish are intentionally not part of the current setup unless the corresponding config directories are added back.

## Repository layout

```txt
.
├── aur.txt                         # AUR package list
├── pac.txt                         # Official Arch package list
├── hyprlock/.config/hypr/          # Hyprlock config
├── mako/.config/mako/              # Notification daemon config
├── niri/.config/niri/              # Niri compositor config
├── nvim/.config/nvim/              # Neovim/LazyVim config
├── rime/.local/share/fcitx5/rime/  # Fcitx5 Rime dictionaries and schemas
├── waybar/.config/waybar/          # Waybar config, style, power menu
├── yazi/.config/yazi/              # Yazi config
├── zathura/.config/zathura/        # Zathura config
├── zim/.zimrc                      # Zim module list
└── zsh/.zshrc                      # Zsh runtime config
```

## Package installation

Install official packages:

```bash
sudo pacman -Syu --needed - < pac.txt
```

Install AUR packages after bootstrapping an AUR helper. `aur.txt` currently includes `paru`, so install `paru` manually first if the system does not already have it:

```bash
git clone https://aur.archlinux.org/paru.git /tmp/paru
cd /tmp/paru
makepkg -si
```

Then install the AUR list:

```bash
paru -S --needed - < aur.txt
```

## Deploy dotfiles

This repository is structured for GNU Stow. From the repository root, stow only the modules you want:

```bash
stow niri waybar mako hyprlock yazi zathura zsh zim nvim rime
```

Before stowing, back up any existing config directories that would conflict, for example:

```bash
mv ~/.config/niri ~/.config/niri.bak 2>/dev/null || true
mv ~/.config/waybar ~/.config/waybar.bak 2>/dev/null || true
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null || true
mv ~/.local/share/fcitx5/rime ~/.local/share/fcitx5/rime.bak 2>/dev/null || true
```

## Session behavior

`niri/.config/niri/config.kdl` starts the main desktop services:

```txt
waybar
awww-daemon
mako
wlsunset
foot --server
polkit-gnome-authentication-agent-1
```

Important keybindings from the current Niri config:

| Key                        | Action                                 |
| -------------------------- | -------------------------------------- |
| `Ctrl+Alt+T`               | Open `footclient`                      |
| `Mod+D`                    | Open Fuzzel launcher                   |
| `Mod+E`                    | Open Yazi inside Foot                  |
| `Super+Alt+L`              | Lock with Hyprlock                     |
| `Mod+B`                    | Toggle Waybar visibility               |
| `XF86MonBrightnessUp/Down` | Adjust brightness with `brightnessctl` |
| `Print`                    | Niri screenshot                        |

## Waybar notes

`waybar/.config/waybar/config.jsonc` includes:

- Niri workspace and window modules.
- Pulseaudio/PipeWire volume display with `pavucontrol` on click.
- Network, battery, temperature, backlight, clock, tray, and custom power menu.
- `power-profiles-daemon` module.

`pac.txt` currently uses:

```txt
tlp
tlp-rdw
tlp-pd
```

`tlp-pd` provides `power-profiles-daemon`, so the Waybar power profiles module can work without installing the standalone `power-profiles-daemon` package. Do not install `power-profiles-daemon` alongside `tlp-pd`; they conflict.

## Input method

The Rime configuration lives in:

```txt
rime/.local/share/fcitx5/rime/
```

The package list includes the Fcitx5/Rime stack:

```txt
fcitx5
fcitx5-chinese-addons
fcitx5-configtool
fcitx5-gtk
fcitx5-qt
fcitx5-rime
```

After stowing the Rime module, restart Fcitx5 or redeploy the schema from the Fcitx5 UI.

## Neovim and Yazi notes

Neovim config is under:

```txt
nvim/.config/nvim/
```

Useful packages kept for this workflow include:

```txt
neovim
ripgrep
fd
lazygit
luarocks
imagemagick
chafa
```

Yazi config is minimal and sets Neovim as the blocking editor:

```toml
[opener]
edit = [
  { run = 'nvim "$@"', block = true }
]
```

Yazi default search shortcuts worth remembering:

| Key | Search type                   | Backend              |
| --- | ----------------------------- | -------------------- |
| `s` | File name search              | `fd`                 |
| `S` | File content search           | `ripgrep` / `rg`     |
| `/` | Find inside current file list | Yazi internal find   |
| `f` | Filter current file list      | Yazi internal filter |

## Fonts and visual assets

The current package list includes:

```txt
noto-fonts
noto-fonts-cjk
noto-fonts-emoji
otf-font-awesome
otf-monaspace-nerd
ttf-dejavu
```

Hyprlock uses `MonaspiceNe Nerd Font Mono`, covered by `otf-monaspace-nerd`.

Mako also plays a notification sound from `ocean-sound-theme`, which is included in `pac.txt`.

## Hardware notes

`pac.txt` is currently Intel-oriented:

```txt
intel-ucode
intel-media-driver
vulkan-intel
```

For AMD or Nvidia machines, replace or extend the hardware packages as needed. Keep hardware-specific packages out of the shared baseline unless every target machine needs them.

## Updating package lists

Official packages:

```bash
pacman -Qqen > pac.txt
```

AUR packages:

```bash
pacman -Qqem > aur.txt
```

Caution: `pacman -Qqen` only exports official packages that are explicitly installed. If a tool is installed only as a dependency but is required for this dotfiles workflow, add it to `pac.txt` manually or mark it explicit:

```bash
sudo pacman -D --asexplicit ripgrep
```

## License

MIT. See `LICENSE` if present in the repository.
