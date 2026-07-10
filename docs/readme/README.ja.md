# Good Arch Setting

[![English](https://img.shields.io/badge/lang-English-blue)](../../README.md)
[![中文](https://img.shields.io/badge/lang-%E4%B8%AD%E6%96%87-red)](README.zh-CN.md)
[![Español](https://img.shields.io/badge/lang-Espa%C3%B1ol-yellow)](README.es.md)
[![日本語](https://img.shields.io/badge/lang-%E6%97%A5%E6%9C%AC%E8%AA%9E-green)](README.ja.md)

Niri ベースの Wayland ワークステーション向けの個人用 Arch Linux dotfiles です。

このリポジトリの目的は、新しい Arch 環境を素早く普段の作業環境に近づけることです。パッケージリストをインストールし、必要なモジュールを Stow で展開し、Wayland セッションにログインします。

## 使用例

この3枚は、デスクトップ全体、Neovim の編集環境、そして普段使いのブラウザを示しています。

### デスクトップ全景

この画像は、Waybar、Foot、Mako などが同じ Niri セッションの中で動いている様子です。

<img src="https://tree-1327913400.cos.ap-nanjing.myqcloud.com/world/20260710200708863.webp" alt="desktop" width="100%" />

### Neovim の環境

この画像は、LazyVim を使った編集環境です。

<img src="https://tree-1327913400.cos.ap-nanjing.myqcloud.com/world/20260710201139819.webp" alt="neovim" width="100%" />

### ブラウザの環境

この画像は、日常的に使っている Zen Browser です。

<img src="https://tree-1327913400.cos.ap-nanjing.myqcloud.com/world/20260710201355158.webp" alt="zen" width="100%" />

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
| ブラウザ                     | Zen Browser                                                       |
| 概要表示                     | Fastfetch                                                         |
| シェル                       | Zsh + Zim, Fzf, Zoxide, Eza                                       |
| 家計管理                     | Hledger                                                           |
| ファイルと文書のワークフロー | Yazi, Zathura, Imv, Mpv                                           |
| パッケージリスト             | `pac.txt` は Arch 公式パッケージ用、`aur.txt` は AUR パッケージ用 |

古い README にある Hyprland、Alacritty、Kitty、Fish への言及は、対応する設定ディレクトリを再追加しない限り、現在の構成には含まれません。

## リポジトリ構成

```txt
.
├── aur.txt                         # AUR パッケージリスト
├── pac.txt                         # Arch 公式パッケージリスト
├── hyprlock/.config/hypr/          # Hyprlock 設定
├── keyd/etc/keyd/                  # keyd のキーボードリマップ設定
├── fastfetch/.config/fastfetch/     # Fastfetch 設定とロゴ
├── mako/.config/mako/              # 通知デーモン設定
├── niri/.config/niri/              # Niri 設定
├── nvim/.config/nvim/              # Neovim/LazyVim 設定
├── rime/.local/share/fcitx5/rime/  # Fcitx5 Rime の辞書とスキーマ
├── scripts/.local/bin/              # 個人用スクリプト
├── waybar/.config/waybar/          # Waybar 設定、スタイル、電源メニュー
├── yazi/.config/yazi/              # Yazi 設定
├── zathura/.config/zathura/        # Zathura 設定
├── zim/.zimrc                      # Zim モジュール一覧
└── zsh/.zshrc                      # Zsh 実行時設定
```

## パッケージのインストール

新しい Arch 環境では、まず `git` をインストールし、このリポジトリを clone してから、リポジトリルートで以降のコマンドを実行します。

```bash
sudo pacman -S git
git clone https://github.com/SaintFore/GoodArchSetting ~/.dotfiles
cd ~/.dotfiles
```

Arch 公式パッケージをインストールします。

```bash
sudo pacman -Syu --needed - < pac.txt
```

`pacman` がインストールする `tesseract-data` パッケージを尋ねた場合は、`eng`（現在のプロンプトでは **30**）を選びます。これは Zathura の PDF ワークフローで必要な依存関係です。後から確認するには次を実行します。

```bash
pacman -Qi tesseract
```

システムにまだ `paru` がない場合は、先に手動でインストールします。

```bash
git clone https://aur.archlinux.org/paru.git /tmp/paru
cd /tmp/paru
makepkg -si
```

`makepkg` が Rust の選択を求めた場合は、`rustup`（現在のプロンプトでは **2**）を選びます。新しい環境ではこの手順に時間がかかることがあります。

必要に応じて、ネットワーク関連の AUR パッケージを先にインストールします。

```bash
paru -S localsend-bin clash-party-bin
```

その後、残りの AUR リストをインストールします。

```bash
paru -S --needed - < aur.txt
```

このデスクトップで使うブラウザは Zen Browser で、そのパッケージはすでに `aur.txt` に含まれています。

## dotfiles の展開

このリポジトリは GNU Stow 向けに構成されています。リポジトリルートから、必要なモジュールを 1 つずつ stow します。

```bash
stow -v <module>
```

例:

```bash
stow -v niri
stow -v waybar
stow -v mako
```

`keyd` は `/etc` 以下へファイルを展開するため例外です。

```bash
stow -v keyd -t /
```

Stow の前に、競合しそうな既存設定をバックアップしてください。

```bash
mv ~/.config/niri ~/.config/niri.bak 2>/dev/null || true
mv ~/.config/waybar ~/.config/waybar.bak 2>/dev/null || true
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null || true
mv ~/.config/fastfetch ~/.config/fastfetch.bak 2>/dev/null || true
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
| `Mod+Alt+I`                | Nerd Font アイコン選択器を開く     |
| `XF86MonBrightnessUp/Down` | `brightnessctl` で明るさを調整する |
| `Print`                    | Niri のスクリーンショット          |

## Waybar メモ

`waybar/.config/waybar/config.jsonc` には次の内容が含まれています。

- Niri のワークスペース、ウィンドウ、モード、scratchpad モジュール。
- MPRIS、Bluetooth、ネットワーク、バッテリー、温度、バックライト、言語、トレイ、プライバシー、カスタム電源メニュー。
- Pulseaudio/PipeWire の音量表示。クリックで `pavucontrol` を開きます。
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

## 便利なスクリプトと家計管理

`scripts/.local/bin/nerd-icon-picker` は `fuzzel` で Nerd Fonts のアイコン一覧を開き、選んだグリフをクリップボードへコピーします。キーバインドは `Mod+Alt+I` です。

`scripts/.local/bin/hlpay` は hledger の支出を素早く追記するためのスクリプトで、既定では次のファイルに書き込みます。

```txt
$HOME/Documents/hledger/main.journal
```

`zsh/.zshrc` でも `LEDGER_FILE` を export しているので、`hlpay` と対話的な shell は同じ台帳を使います。

## Fastfetch

`fastfetch/.config/fastfetch/config.jsonc` は `chafa` でローカルロゴを描画します。設定と画像はどちらも `fastfetch/.config/fastfetch/` にあります。

ロゴを変える場合は `fastfetch/logo.jpg` を差し替えてください。

`fastfetch` はすでに `pac.txt` に入っているので、公式パッケージの導入後すぐに使えます。

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

`aur.txt` には、より読みやすい中国語表示のための `ttf-lxgw-wenkai` も含めています。

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
