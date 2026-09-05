# Good Arch Setting

[![English](https://img.shields.io/badge/lang-English-blue)](../../README.md)
[![中文](https://img.shields.io/badge/lang-%E4%B8%AD%E6%96%87-red)](README.zh-CN.md)
[![Español](https://img.shields.io/badge/lang-Espa%C3%B1ol-yellow)](README.es.md)
[![日本語](https://img.shields.io/badge/lang-%E6%97%A5%E6%9C%AC%E8%AA%9E-green)](README.ja.md)

这是我为 Niri Wayland 工作站整理的 Arch Linux dotfiles。

这个仓库的目标很直接：让一台新装的 Arch 机器尽快恢复成熟悉的工作环境。先装好包，再按需 stow 各个模块，随后直接进入 Wayland 会话。

## 使用场景

这三张图分别对应桌面全景、Neovim 编辑环境，以及日常使用的浏览器界面。

### 桌面全景

<img src="https://tree-1327913400.cos.ap-nanjing.myqcloud.com/world/20260710200708863.webp" alt="desktop" width="100%" />

### Neovim 编辑环境

<img src="https://tree-1327913400.cos.ap-nanjing.myqcloud.com/world/20260710201139819.webp" alt="neovim" width="100%" />

### 浏览器界面

<img src="https://tree-1327913400.cos.ap-nanjing.myqcloud.com/world/20260710201355158.webp" alt="zen" width="100%" />

## 当前组成

仓库当前围绕这些组件展开：

| 范围               | 组件                                                       |
| ------------------ | ---------------------------------------------------------- |
| Wayland 会话       | Niri, UWSM, SDDM                                           |
| 状态栏和桌面外壳   | Waybar, Fuzzel, Foot, Mako, Awww, Wlsunset                 |
| 锁屏和空闲管理     | Hyprlock, Swayidle                                         |
| 音频和基础屏幕共享 | PipeWire, WirePlumber, Pavucontrol, xdg-desktop-portal-gtk |
| 输入法             | Fcitx5 + Rime                                              |
| 编辑器             | Neovim / LazyVim                                           |
| 浏览器             | Zen Browser                                                |
| 系统概览           | Fastfetch                                                  |
| Shell              | Zsh + Zim, Fzf, Zoxide, Eza                                |
| 记账               | Hledger                                                    |
| 文件和文档工作流   | Yazi, Zathura, Imv, Mpv                                    |
| 包清单             | `pac.txt` 用于官方仓库基础包，`aur.txt` 用于 AUR 包，`game.txt` 用于可选游戏和硬件包 |

旧 README 中关于 Hyprland、Alacritty、Kitty 或 Fish 的描述不代表当前配置，除非之后重新加入对应配置目录。

## 仓库结构

```txt
.
├── aur.txt                         # AUR 包清单
├── game.txt                        # 可选游戏及 Intel/NVIDIA 包清单
├── pac.txt                         # Arch 官方仓库包清单
├── hyprlock/.config/hypr/          # Hyprlock 配置
├── keyd/etc/keyd/                  # keyd 键盘重映射配置
├── fastfetch/.config/fastfetch/    # Fastfetch 配置和 Logo
├── mako/.config/mako/              # 通知守护进程配置
├── niri/.config/niri/              # Niri compositor 配置
├── nvim/.config/nvim/              # Neovim/LazyVim 配置
├── rime/.local/share/fcitx5/rime/  # Fcitx5 Rime 词库和方案
├── scripts/.local/bin/             # 自用脚本
├── waybar/.config/waybar/          # Waybar 配置、样式和电源菜单
├── yazi/.config/yazi/              # Yazi 配置
├── zathura/.config/zathura/        # Zathura 配置
├── zim/.zimrc                      # Zim 模块列表
└── zsh/.zshrc                      # Zsh 运行时配置
```

## 安装软件包

在全新的 Arch 系统上，先安装 `git`，克隆仓库，然后从仓库根目录执行后续命令：

```bash
sudo pacman -S git
git clone https://github.com/SaintFore/GoodArchSetting ~/.dotfiles
cd ~/.dotfiles
```

先安装 Arch 官方仓库包：

```bash
sudo pacman -Syu --needed - < pac.txt
```

游戏设备可按需安装 Intel/NVIDIA 与 Steam 软件栈：

```bash
sudo pacman -Syu --needed - < game.txt
```

如果 `pacman` 提示选择 `tesseract-data`，选择 `eng`（当前提示中是 **30**）。这是 Zathura PDF 工作流需要的依赖。之后可以用下面的命令查看依赖信息：

```bash
pacman -Qi tesseract
```

如果系统还没有 `paru`，先手动安装：

```bash
git clone https://aur.archlinux.org/paru.git /tmp/paru
cd /tmp/paru
makepkg -si
```

如果 `makepkg` 提示安装 Rust，选择 `rustup`（当前提示中是 **2**）。这个步骤在新机器上可能需要等待很长时间。

需要时，先安装和网络相关的 AUR 包：

```bash
paru -S localsend-bin clash-party-bin
```

然后再安装剩余的 AUR 清单：

```bash
paru -S --needed - < aur.txt
```

桌面浏览器我使用 Zen Browser，对应的包已经写入 `aur.txt`。

## 部署 dotfiles

仓库按 GNU Stow 组织。从仓库根目录按需逐个 stow 模块：

```bash
stow -v <module>
```

例如：

```bash
stow -v niri
stow -v waybar
stow -v mako
```

`keyd` 是例外，因为它会把文件部署到 `/etc`：

```bash
stow -v keyd -t /
```

stow 之前先备份可能冲突的现有配置，例如：

```bash
mv ~/.config/niri ~/.config/niri.bak 2>/dev/null || true
mv ~/.config/waybar ~/.config/waybar.bak 2>/dev/null || true
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null || true
mv ~/.config/fastfetch ~/.config/fastfetch.bak 2>/dev/null || true
mv ~/.local/share/fcitx5/rime ~/.local/share/fcitx5/rime.bak 2>/dev/null || true
```

## 会话行为

`niri/.config/niri/config.kdl` 会启动主要桌面服务：

```txt
waybar
awww-daemon
mako
wlsunset
foot --server
polkit-gnome-authentication-agent-1
```

当前 Niri 配置中的重要快捷键：

| 按键                       | 动作                          |
| -------------------------- | ----------------------------- |
| `Ctrl+Alt+T`               | 打开 `footclient`             |
| `Mod+D`                    | 打开 Fuzzel 启动器            |
| `Mod+E`                    | 在 Foot 中打开 Yazi           |
| `Super+Alt+L`              | 使用 Hyprlock 锁屏            |
| `Mod+B`                    | 切换 Waybar 显示状态          |
| `Mod+Alt+I`                | 打开 Nerd Font 图标选择器     |
| `XF86MonBrightnessUp/Down` | 使用 `brightnessctl` 调整亮度 |
| `Print`                    | Niri 截图                     |

## Waybar 说明

`waybar/.config/waybar/config.jsonc` 包含：

- Niri 工作区、窗口、模式和 scratchpad 模块。
- MPRIS 媒体控制、蓝牙、网络、电池、温度、背光、语言、托盘、隐私指示和自定义电源菜单。
- Pulseaudio/PipeWire 音量显示，点击打开 `pavucontrol`。
- `power-profiles-daemon` 模块。

`pac.txt` 当前使用：

```txt
tlp
tlp-rdw
tlp-pd
```

`tlp-pd` 提供 `power-profiles-daemon`，所以 Waybar 的 power profiles 模块可以在不安装独立 `power-profiles-daemon` 包的情况下工作。不要同时安装 `power-profiles-daemon` 和 `tlp-pd`，二者冲突。

## 输入法

Rime 配置位于：

```txt
rime/.local/share/fcitx5/rime/
```

包清单包含 Fcitx5/Rime 栈：

```txt
fcitx5
fcitx5-chinese-addons
fcitx5-configtool
fcitx5-gtk
fcitx5-qt
fcitx5-rime
```

stow Rime 模块后，重启 Fcitx5 或在 Fcitx5 UI 中重新部署方案。

## Neovim 和 Yazi 说明

Neovim 配置位于：

```txt
nvim/.config/nvim/
```

为此工作流保留的常用包包括：

```txt
neovim
ripgrep
fd
lazygit
luarocks
imagemagick
chafa
```

Yazi 配置很小，只把 Neovim 设为阻塞式编辑器：

```toml
[opener]
edit = [
  { run = 'nvim "$@"', block = true }
]
```

值得记住的 Yazi 默认搜索快捷键：

| 按键 | 搜索类型             | 后端             |
| ---- | -------------------- | ---------------- |
| `s`  | 文件名搜索           | `fd`             |
| `S`  | 文件内容搜索         | `ripgrep` / `rg` |
| `/`  | 在当前文件列表中查找 | Yazi 内部 find   |
| `f`  | 过滤当前文件列表     | Yazi 内部 filter |

## 实用脚本和记账

`scripts/.local/bin/nerd-icon-picker` 会通过 `fuzzel` 打开 Nerd Fonts 图标列表，选中的图标会复制到剪贴板。它对应的快捷键是 `Mod+Alt+I`。

`scripts/.local/bin/hlpay` 用来快速追加一笔 hledger 支出记录，默认写入：

```txt
$HOME/Documents/hledger/main.journal
```

`zsh/.zshrc` 里同时导出了 `LEDGER_FILE`，所以 `hlpay` 和交互式 shell 会使用同一个账本路径。

## Fastfetch

`fastfetch/.config/fastfetch/config.jsonc` 使用 `chafa` 渲染本地 Logo，配置文件和图片都放在 `fastfetch/.config/fastfetch/`。

如果要更换 Logo 请更改 `fastfetch/` 下的 `logo.jpg` 文件。

`fastfetch` 本身已经包含在 `pac.txt` 里，所以新机器上装完官方包之后就能直接用。

## 字体和视觉资源

当前包清单包含：

```txt
noto-fonts
noto-fonts-cjk
noto-fonts-emoji
otf-font-awesome
otf-monaspace-nerd
ttf-dejavu
```

`aur.txt` 里还包含 `ttf-lxgw-wenkai`，用于中文显示时补充更顺眼的字体。

Hyprlock 使用 `MonaspiceNe Nerd Font Mono`，由 `otf-monaspace-nerd` 覆盖。

Mako 还会播放来自 `ocean-sound-theme` 的通知音效，该包已包含在 `pac.txt` 中。

## 硬件说明

Intel/NVIDIA 硬件包和 Steam 游戏栈统一放在可选的 `game.txt` 中：

```txt
intel-ucode
intel-media-driver
vulkan-intel
nvidia-open
libva-nvidia-driver
steam
```

即使使用 NVIDIA 显卡，只要 CPU 是 Intel，通常仍然需要 `intel-ucode`；只有继续使用 Intel 核显时才需要 Intel 图形驱动。请根据设备选择 `game.txt` 中的包，不必整份全部安装。

## 更新包清单

官方仓库包：

```bash
pacman -Qqen > /tmp/pac-explicit.txt
```

AUR 包：

```bash
pacman -Qqem > /tmp/aur-explicit.txt
```

注意：请将临时快照与三个整理后的清单进行比较，不要直接覆盖清单。`pacman -Qqen` 会把基础包、游戏包、硬件专用包和无关应用混在一起，而且只导出“官方仓库 + 显式安装”的包。如果某个工具只是作为依赖安装，但它对这个 dotfiles 工作流是必需的，就需要手动加入 `pac.txt`，或者把它标记为显式安装：

```bash
sudo pacman -D --asexplicit ripgrep
```
