# ⚙️ GoodArchSetting

这是一个我个人的 Arch Linux 配置合集，也称为 "dotfiles"。它包含了我日常使用的各种工具的配置文件。

## 🎨 主题和风格

我的配置旨在提供一个美观、高效和个性化的工作环境。我主要使用 `Hyprland` 作为我的窗口管理器，并使用 `waybar` 作为我的状态栏。

## 包含的配置

这个仓库包含了以下工具的配置文件：

- **终端**:
    - `alacritty`
    - `kitty`
- **窗口管理器**:
    - `hypr` (Hyprland)
    - `niri`
- **编辑器**:
    - `nvim` (Neovim)
- **状态栏**:
    - `waybar`
- **Shell**:
    - `zsh`
- **其他**:
    - `zim` (Zim Wiki)

## 🚀 如何使用

**免责声明:** 这些是我的个人配置文件。直接使用它们可能会覆盖你自己的配置。在使用前，请务必备份你自己的配置文件。

你可以将此仓库克隆到你的 home 目录，然后根据需要将相应的配置文件软链接到你的 `~/.config` 目录。

例如，要使用我的 `nvim` 配置，你可以这样做：

```bash
# 1. 备份你自己的 nvim 配置
mv ~/.config/nvim ~/.config/nvim.bak

# 2. 克隆此仓库
git clone https://github.com/SaintFore/GoodArchSetting.git ~/GoodArchSetting

# 3. 创建软链接
ln -s ~/GoodArchSetting/nvim ~/.config/nvim
```

## 🤝 贡献

欢迎任何形式的贡献！如果你有任何建议或问题，请随时提出 Issue。
