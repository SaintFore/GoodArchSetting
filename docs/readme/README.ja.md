# Good Arch Setting

[![English](https://img.shields.io/badge/lang-English-blue)](../../README.md)
[![中文](https://img.shields.io/badge/lang-%E4%B8%AD%E6%96%87-red)](README.zh-CN.md)
[![Español](https://img.shields.io/badge/lang-Espa%C3%B1ol-yellow)](README.es.md)
[![日本語](https://img.shields.io/badge/lang-%E6%97%A5%E6%9C%AC%E8%AA%9E-green)](README.ja.md)

Niri ベースの Wayland ワークステーション向けの個人用 Arch Linux dotfiles です。

このリポジトリの目的は、新しい Arch 環境を素早く普段の作業環境に近づけることです。パッケージリストをインストールし、必要なモジュールを Stow で展開し、Wayland セッションにログインします。

## 現在の構成

現在のリポジトリは次の構成を前提にしています。

| 領域                         | コンポーネント                                                    |
| ---------------------------- | ----------------------------------------------------------------- |
| Wayland セッション           | Niri, UWSM, SDDM                                                  |
| バーとデスクトップ周辺       | Waybar, Fuzzel, Foot, Mako, Awww, Wlsunset                        |
| ロックとアイドル管理         | Hyprlock, Swayidle                                                |
| 音声と画面共有の基本         | PipeWire, WirePlumber, Pavucontrol, xdg-desktop-portal-gtk        |
| 入力メソッド                 | Fcitx5 + Rime                                                     |
| エディタ                     | Neovim / LazyVim                                                  |
| シェル                       | Zsh + Zim, Fzf, Zoxide, Eza                                       |
| ファイルと文書のワークフロー | Yazi, Thunar, Zathura, Imv, Mpv                                   |
| パッケージリスト             | `pac.txt` は Arch 公式パッケージ用、`aur.txt` は AUR パッケージ用 |

古い README にある Hyprland、Alacritty、Kitty、Fish への言及は、対応する設定ディレクトリを再追加しない限り、現在の構成には含まれません。

## リポジトリ構成

```txt
.
├── aur.txt                         # AUR パッケージリスト
├── pac.txt                         # Arch 公式パッケージリスト
├── hyprlock/.config/hypr/          # Hyprlock 設定
├── mako/.config/mako/              # 通知デーモン設定
├── niri/.config/niri/              # Niri 設定
├── nvim/.config/nvim/              # Neovim/LazyVim 設定
├── rime/.local/share/fcitx5/rime/  # Fcitx5 Rime の辞書とスキーマ
├── waybar/.config/waybar/          # Waybar 設定、スタイル、電源メニュー
├── yazi/.config/yazi/              # Yazi 設定
├── zathura/.config/zathura/        # Zathura 設定
├── zim/.zimrc                      # Zim モジュール一覧
└── zsh/.zshrc                      # Zsh 実行時設定
```

## パッケージのインストール

公式パッケージをインストールします。

```bash
sudo pacman -Syu --needed - < pac.txt
```

AUR パッケージをインストールするには、先に AUR helper が必要です。`aur.txt` には `paru` が含まれているため、まだ `paru` がない場合は先に手動でインストールします。

```bash
git clone https://aur.archlinux.org/paru.git /tmp/paru
cd /tmp/paru
makepkg -si
```

その後、AUR リストをインストールします。

```bash
paru -S --needed - < aur.txt
```

## dotfiles の展開

このリポジトリは GNU Stow 向けに構成されています。リポジトリのルートから、必要なモジュールだけを stow します。

```bash
stow niri waybar mako hyprlock yazi zathura zsh zim nvim rime
```

Stow の前に、競合しそうな既存設定をバックアップしてください。

```bash
mv ~/.config/niri ~/.config/niri.bak 2>/dev/null || true
mv ~/.config/waybar ~/.config/waybar.bak 2>/dev/null || true
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null || true
mv ~/.local/share/fcitx5/rime ~/.local/share/fcitx5/rime.bak 2>/dev/null || true
```

## セッションの動作

`niri/.config/niri/config.kdl` は主要なデスクトップサービスを起動します。

```txt
waybar
awww-daemon
mako
wlsunset
foot --server
polkit-gnome-authentication-agent-1
```

現在の Niri 設定にある主なキーバインドです。

| キー                       | 動作                               |
| -------------------------- | ---------------------------------- |
| `Ctrl+Alt+T`               | `footclient` を開く                |
| `Mod+D`                    | Fuzzel ランチャーを開く            |
| `Mod+E`                    | Foot 内で Yazi を開く              |
| `Super+Alt+L`              | Hyprlock でロックする              |
| `Mod+B`                    | Waybar の表示を切り替える          |
| `XF86MonBrightnessUp/Down` | `brightnessctl` で明るさを調整する |
| `Print`                    | Niri のスクリーンショット          |

## Waybar メモ

`waybar/.config/waybar/config.jsonc` には次の内容が含まれています。

- Niri のワークスペースとウィンドウモジュール。
- Pulseaudio/PipeWire の音量表示。クリックで `pavucontrol` を開きます。
- ネットワーク、バッテリー、温度、バックライト、時計、トレイ、カスタム電源メニュー。
- `power-profiles-daemon` モジュール。

`pac.txt` は現在これらを使用します。

```txt
tlp
tlp-rdw
tlp-pd
```

`tlp-pd` は `power-profiles-daemon` を提供するため、独立した `power-profiles-daemon` パッケージを入れなくても Waybar の power profiles モジュールを利用できます。`power-profiles-daemon` と `tlp-pd` は競合するため、同時にインストールしないでください。

## 入力メソッド

Rime 設定は次の場所にあります。

```txt
rime/.local/share/fcitx5/rime/
```

パッケージリストには Fcitx5/Rime スタックが含まれます。

```txt
fcitx5
fcitx5-chinese-addons
fcitx5-configtool
fcitx5-gtk
fcitx5-qt
fcitx5-rime
```

Rime モジュールを stow した後、Fcitx5 を再起動するか、Fcitx5 の UI からスキーマを再デプロイしてください。

## Neovim と Yazi のメモ

Neovim 設定は次の場所にあります。

```txt
nvim/.config/nvim/
```

このワークフローのために残している便利なパッケージです。

```txt
neovim
ripgrep
fd
lazygit
luarocks
imagemagick
chafa
```

Yazi 設定は最小限で、Neovim をブロッキングエディタとして設定しています。

```toml
[opener]
edit = [
  { run = 'nvim "$@"', block = true }
]
```

覚えておくと便利な Yazi のデフォルト検索キーです。

| キー | 検索種別                       | バックエンド     |
| ---- | ------------------------------ | ---------------- |
| `s`  | ファイル名検索                 | `fd`             |
| `S`  | ファイル内容検索               | `ripgrep` / `rg` |
| `/`  | 現在のファイルリスト内で検索   | Yazi 内部 find   |
| `f`  | 現在のファイルリストをフィルタ | Yazi 内部 filter |

## フォントと見た目のリソース

現在のパッケージリストには次が含まれています。

```txt
noto-fonts
noto-fonts-cjk
noto-fonts-emoji
otf-font-awesome
otf-monaspace-nerd
ttf-dejavu
```

Hyprlock は `MonaspiceNe Nerd Font Mono` を使用し、これは `otf-monaspace-nerd` で提供されます。

Mako は `ocean-sound-theme` の通知音も再生します。このパッケージは `pac.txt` に含まれています。

## ハードウェアに関するメモ

`pac.txt` は現在 Intel 向けです。

```txt
intel-ucode
intel-media-driver
vulkan-intel
```

AMD または Nvidia のマシンでは、必要に応じてハードウェア関連パッケージを置き換えるか追加してください。すべての対象マシンで必要ではないハードウェア専用パッケージは、共有ベースラインに混ぜない方針です。

## パッケージリストの更新

公式パッケージ：

```bash
pacman -Qqen > pac.txt
```

AUR パッケージ：

```bash
pacman -Qqem > aur.txt
```

注意：`pacman -Qqen` は公式リポジトリ由来で明示的にインストールされたパッケージだけを出力します。依存関係として入っただけのツールでも、この dotfiles ワークフローに必要なら、手動で `pac.txt` に追加するか、明示インストール扱いに変更してください。

```bash
sudo pacman -D --asexplicit ripgrep
```

## ライセンス

MIT。リポジトリに `LICENSE` ファイルが存在する場合は、その内容を優先してください。
