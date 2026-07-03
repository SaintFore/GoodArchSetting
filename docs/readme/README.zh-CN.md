# Good Arch Setting

[![English](https://img.shields.io/badge/lang-English-blue)](../../README.md)
[![中文](https://img.shields.io/badge/lang-%E4%B8%AD%E6%96%87-red)](README.zh-CN.md)
[![Español](https://img.shields.io/badge/lang-Espa%C3%B1ol-yellow)](README.es.md)
[![日本語](https://img.shields.io/badge/lang-%E6%97%A5%E6%9C%AC%E8%AA%9E-green)](README.ja.md)

面向 Niri Wayland 工作站的个人 Arch Linux dotfiles。

这个仓库用于让一台新的 Arch 机器快速接近熟悉的工作环境：安装包清单，按需 stow 配置模块，然后登录 Wayland 会话。

## 当前技术栈

当前仓库状态基于这些组件：

| 范围               | 组件                                                       |
| ------------------ | ---------------------------------------------------------- |
| Wayland 会话       | Niri, UWSM, SDDM                                           |
| 状态栏和桌面外壳   | Waybar, Fuzzel, Foot, Mako, Awww, Wlsunset                 |
| 锁屏和空闲管理     | Hyprlock, Swayidle                                         |
| 音频和基础屏幕共享 | PipeWire, WirePlumber, Pavucontrol, xdg-desktop-portal-gtk |
| 输入法             | Fcitx5 + Rime                                              |
| 编辑器             | Neovim / LazyVim                                           |
| Shell              | Zsh + Zim, Fzf, Zoxide, Eza                                |
| 文件和文档工作流   | Yazi, Thunar, Zathura, Imv, Mpv                            |
| 包清单             | `pac.txt` 用于 Arch 官方仓库包，`aur.txt` 用于 AUR 包      |

旧 README 中关于 Hyprland、Alacritty、Kitty 或 Fish 的描述不代表当前配置，除非之后重新加入对应配置目录。

## 仓库结构

```txt
.
├── aur.txt                         # AUR 包清单
├── pac.txt                         # Arch 官方仓库包清单
├── hyprlock/.config/hypr/          # Hyprlock 配置
├── mako/.config/mako/              # 通知守护进程配置
├── niri/.config/niri/              # Niri compositor 配置
├── nvim/.config/nvim/              # Neovim/LazyVim 配置
├── rime/.local/share/fcitx5/rime/  # Fcitx5 Rime 词库和方案
├── waybar/.config/waybar/          # Waybar 配置、样式和电源菜单
├── yazi/.config/yazi/              # Yazi 配置
├── zathura/.config/zathura/        # Zathura 配置
├── zim/.zimrc                      # Zim 模块列表
└── zsh/.zshrc                      # Zsh 运行时配置
```

## 安装软件包

安装官方仓库包：

```bash
sudo pacman -Syu --needed - < pac.txt
```

安装 AUR 包前需要先准备 AUR helper。`aur.txt` 当前包含 `paru`，所以如果系统还没有 `paru`，先手动安装：

```bash
git clone https://aur.archlinux.org/paru.git /tmp/paru
cd /tmp/paru
makepkg -si
```

然后安装 AUR 清单：

```bash
paru -S --needed - < aur.txt
```

## 部署 dotfiles

仓库按 GNU Stow 组织。从仓库根目录按需 stow 模块：

```bash
stow niri waybar mako hyprlock yazi zathura zsh zim nvim rime
```

stow 之前先备份可能冲突的现有配置，例如：

```bash
mv ~/.config/niri ~/.config/niri.bak 2>/dev/null || true
mv ~/.config/waybar ~/.config/waybar.bak 2>/dev/null || true
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null || true
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
| `XF86MonBrightnessUp/Down` | 使用 `brightnessctl` 调整亮度 |
| `Print`                    | Niri 截图                     |

## Waybar 说明

`waybar/.config/waybar/config.jsonc` 包含：

- Niri 工作区和窗口模块。
- Pulseaudio/PipeWire 音量显示，点击打开 `pavucontrol`。
- 网络、电池、温度、背光、时钟、托盘和自定义电源菜单。
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

Hyprlock 使用 `MonaspiceNe Nerd Font Mono`，由 `otf-monaspace-nerd` 覆盖。

Mako 还会播放来自 `ocean-sound-theme` 的通知音效，该包已包含在 `pac.txt` 中。

## 硬件说明

`pac.txt` 当前偏向 Intel 硬件：

```txt
intel-ucode
intel-media-driver
vulkan-intel
```

如果目标机器是 AMD 或 Nvidia，请按需要替换或扩展硬件包。不要把并非所有目标机器都需要的硬件专用包混进共享基础清单。

## 更新包清单

官方仓库包：

```bash
pacman -Qqen > pac.txt
```

AUR 包：

```bash
pacman -Qqem > aur.txt
```

注意：`pacman -Qqen` 只导出“官方仓库 + 显式安装”的包。如果某个工具只是作为依赖安装，但它对这个 dotfiles 工作流是必需的，就需要手动加入 `pac.txt`，或者把它标记为显式安装：

```bash
sudo pacman -D --asexplicit ripgrep
```
