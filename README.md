# Good Arch Setting

[![English](https://img.shields.io/badge/lang-English-blue)](README.md)
[![中文](https://img.shields.io/badge/lang-%E4%B8%AD%E6%96%87-red)](docs/readme/README.zh-CN.md)
[![Español](https://img.shields.io/badge/lang-Espa%C3%B1ol-yellow)](docs/readme/README.es.md)
[![日本語](https://img.shields.io/badge/lang-%E6%97%A5%E6%9C%AC%E8%AA%9E-green)](docs/readme/README.ja.md)

Personal Arch Linux dotfiles for a Niri-based Wayland workstation.

This repository is meant to make a fresh Arch install feel familiar quickly: install the package lists, stow the selected modules, then log into the Wayland session.

## Usage examples

These three screenshots show the desktop as a whole, the Neovim editing setup, and the browser I use day to day.

### Desktop overview

This screenshot shows the current Niri desktop, with Waybar, Foot, Mako, and the rest of the session working together.

<img src="https://tree-1327913400.cos.ap-nanjing.myqcloud.com/world/20260710200708863.webp" alt="desktop" width="100%" />

### Neovim setup

This screenshot shows my LazyVim-based editing environment.

<img src="https://tree-1327913400.cos.ap-nanjing.myqcloud.com/world/20260710201139819.webp" alt="neovim" width="100%" />

### Browser setup

This screenshot shows Zen Browser in everyday use.

<img src="https://tree-1327913400.cos.ap-nanjing.myqcloud.com/world/20260710201355158.webp" alt="zen" width="100%" />

## Current components

The repository currently centers on these components:

| Area                            | Components                                                       |
| ------------------------------- | ---------------------------------------------------------------- |
| Wayland session                 | Niri, UWSM, SDDM                                                 |
| Bar and desktop shell           | Waybar, Fuzzel, Foot, Mako, Awww, Wlsunset                       |
| Lock and idle                   | Hyprlock, Swayidle                                               |
| Audio and screen sharing basics | PipeWire, WirePlumber, Pavucontrol, xdg-desktop-portal-gtk       |
| Input method                    | Fcitx5 + Rime                                                    |
| Editor                          | Neovim / LazyVim                                                 |
| Browser                         | Zen Browser                                                      |
| Shell                           | Zsh + Zim, Fzf, Zoxide, Eza                                      |
| Overview                       | Fastfetch                                                        |
| Accounting                      | Hledger                                                          |
| File and document workflow      | Yazi, Zathura, Imv, Mpv                                          |
| Package lists                   | `pac.txt` for official Arch packages, `aur.txt` for AUR packages |

Old README references to Hyprland, Alacritty, Kitty, or Fish are intentionally not part of the current setup unless the corresponding config directories are added back.

## Repository layout

```txt
.
├── aur.txt                         # AUR package list
├── pac.txt                         # Official Arch package list
├── hyprlock/.config/hypr/          # Hyprlock config
├── keyd/etc/keyd/                  # keyd keyboard remapping config
├── fastfetch/.config/fastfetch/     # Fastfetch config and logo
├── mako/.config/mako/              # Notification daemon config
├── niri/.config/niri/              # Niri compositor config
├── nvim/.config/nvim/              # Neovim/LazyVim config
├── rime/.local/share/fcitx5/rime/  # Fcitx5 Rime dictionaries and schemas
├── scripts/.local/bin/              # Personal scripts
├── waybar/.config/waybar/          # Waybar config, style, power menu
├── yazi/.config/yazi/              # Yazi config
├── zathura/.config/zathura/        # Zathura config
├── zim/.zimrc                      # Zim module list
└── zsh/.zshrc                      # Zsh runtime config
```

## Package installation

On a fresh Arch system, install `git`, clone this repository, then run the package commands from the repository root:

```bash
sudo pacman -S git
git clone https://github.com/SaintFore/GoodArchSetting ~/.dotfiles
cd ~/.dotfiles
```

Install the official Arch packages:

```bash
sudo pacman -Syu --needed - < pac.txt
```

If `pacman` asks which `tesseract-data` package to install, choose `eng` (currently option **30**). This dependency is needed by the Zathura PDF workflow. You can inspect it later with:

```bash
pacman -Qi tesseract
```

Install `paru` manually if the system does not already have it:

```bash
git clone https://aur.archlinux.org/paru.git /tmp/paru
cd /tmp/paru
makepkg -si
```

If `makepkg` asks for Rust, choose `rustup` (currently option **2**). This step can take a long time on a fresh install.

Install the network-related AUR packages first when needed:

```bash
paru -S localsend-bin clash-party-bin
```

Then install the remaining AUR list:

```bash
paru -S --needed - < aur.txt
```

Zen Browser is the browser I use on this desktop, and its package is already listed in `aur.txt`.

## Deploy dotfiles

This repository is structured for GNU Stow. From the repository root, stow each module you want:

```bash
stow -v <module>
```

For example:

```bash
stow -v niri
stow -v waybar
stow -v mako
```

`keyd` is the exception because it deploys files under `/etc`:

```bash
stow -v keyd -t /
```

Before stowing, back up any existing config directories that would conflict, for example:

```bash
mv ~/.config/niri ~/.config/niri.bak 2>/dev/null || true
mv ~/.config/waybar ~/.config/waybar.bak 2>/dev/null || true
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null || true
mv ~/.config/fastfetch ~/.config/fastfetch.bak 2>/dev/null || true
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
| `Mod+Alt+I`                | Open the Nerd Font icon picker         |
| `XF86MonBrightnessUp/Down` | Adjust brightness with `brightnessctl` |
| `Print`                    | Niri screenshot                        |

## Waybar notes

`waybar/.config/waybar/config.jsonc` includes:

- Niri workspace, window, mode, and scratchpad modules.
- MPRIS media controls, Bluetooth, network, battery, temperature, backlight, language, tray, privacy, and custom power menu.
- Pulseaudio/PipeWire volume display with `pavucontrol` on click.
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

## Utility scripts and accounting

`scripts/.local/bin/nerd-icon-picker` opens a Nerd Fonts icon list through `fuzzel`, then copies the selected glyph to the clipboard. It is bound to `Mod+Alt+I`.

`scripts/.local/bin/hlpay` appends a quick hledger expense entry and writes to:

```txt
$HOME/Documents/hledger/main.journal
```

`zsh/.zshrc` also exports `LEDGER_FILE`, so `hlpay` and interactive shells use the same ledger path.

## Fastfetch

`fastfetch/.config/fastfetch/config.jsonc` uses `chafa` to render a local logo. Both the config and the image live under `fastfetch/.config/fastfetch/`.

If you want to change the logo, replace `fastfetch/logo.jpg`.

`fastfetch` is already listed in `pac.txt`, so it is available right after installing the official packages.

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

`aur.txt` also includes `ttf-lxgw-wenkai` for better Chinese typography.

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
