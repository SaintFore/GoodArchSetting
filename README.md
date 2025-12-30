# ⚙️ GOOD ARCH SETTING

```text
   ______                 __      ___                __      
  / ____/____  ____  ____/ /     /   |  __________  / /_     
 / / __ / __ \/ __ \/ __  /     / /| | / ___/ ___/ / __ \    
/ /_/ / /_/ / /_/ / /_/ /     / ___ |/ /  / /__  / / / /    
\____/\____/\____/\__,_/     /_/  |_/_/   \___/ /_/ /_/     
   _____      __  __  _                                      
  / ___/___  / /_/ /_(_)___  ____ _                          
  \__ \/ _ \/ __/ __/ / __ \/ __ `/                          
 ___/ /  __/ /_/ /_/ / / / / /_/ /                           
/____/\___/\__/\__/_/_/ /_/\__, /                            
                          /____/                             
```

<div align="center">

[![Arch Linux](https://img.shields.io/badge/Arch_Linux-1793D1?style=for-the-badge&logo=arch-linux&logoColor=white)](https://archlinux.org/)
[![Lua](https://img.shields.io/badge/Lua-2C2D72?style=for-the-badge&logo=lua&logoColor=white)](https://www.lua.org/)
[![Neovim](https://img.shields.io/badge/Neovim-57A143?style=for-the-badge&logo=neovim&logoColor=white)](https://neovim.io/)
[![Hyprland](https://img.shields.io/badge/Hyprland-00C1D4?style=for-the-badge&logo=hyprland&logoColor=white)](https://hyprland.org/)
[![License](https://img.shields.io/badge/License-MIT-blue.svg?style=for-the-badge)](LICENSE)

**"Crafting a workspace that feels like home, only faster."**
打造一个如家般舒适、却更高效的数字空间。

[Installation](#installation) • [Components](#components) • [Features](#features) • [License](#license)

</div>

---

## ⚡ What is GoodArchSetting?

这是我的个人 **Arch Linux Dotfiles** 合集。经过数次迭代，这个仓库沉淀了我对极致生产力和美学设计的追求。它不仅仅是配置，更是一套完整、连贯的现代化 Linux 工作流。

**基于 Wayland，面向未来的极客环境。**

## 🚀 Features

- **🎨 Aesthetic Wayland Setup**: 采用 Hyprland 与 Niri 作为核心窗口管理器，搭配 Waybar 实现极致视觉统一。
- **🚀 Ultra-Optimized Neovim**: 深度定制的 Lua 配置，秒开、全能，让代码编写成为一种享受。
- **🐚 Polished Zsh Environment**: 极致的 Shell 体验，集成了语法高亮、自动补全与高效别名。
- **🛠️ Seamless Dotfiles Management**: 结构清晰，支持快速同步与按需软链接。

## 📦 Components

这个仓库包含了以下核心组件的精心配置：

- **WMs**: `Hyprland`, `Niri`
- **Terminals**: `Alacritty`, `Kitty`
- **Editor**: `Neovim` (Native Lua)
- **Shell**: `Zsh`, `Fish` (Coming soon)
- **Bar**: `Waybar`
- **Wiki**: `Zim`

## 💻 Installation

> **Warning**: 这些是个人配置。直接应用前请务必备份你现有的 `~/.config`。

### 1. 克隆仓库
```bash
git clone https://github.com/SaintFore/GoodArchSetting.git ~/GoodArchSetting
```

### 2. 部署配置 (以 Neovim 为例)
```bash
# 备份旧配置
mv ~/.config/nvim ~/.config/nvim.bak
# 创建软链接
ln -s ~/GoodArchSetting/nvim ~/.config/nvim
```

### 3. 系统字体与依赖
确保安装了 `JetBrainsMono Nerd Font` 以及核心工具包（`hyprland`, `waybar`, `swww` 等）。

## 📄 License

Based on the MIT License. See [LICENSE](LICENSE) for details.

---

<div align="center">
Created with ⚙️ by <a href="https://github.com/SaintFore">SaintFore</a>
</div>
