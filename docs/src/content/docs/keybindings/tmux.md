---
title: tmux キーバインド
description: tmux のキーバインド一覧
sidebar:
  order: 3
---

## Prefix キー

`C-g`（Ctrl + g）がプレフィックスキーです。

---

## セッション / ウィンドウ

| キー        | 動作             |
| ----------- | ---------------- |
| `prefix r`  | 設定リロード     |
| `prefix -`  | ペイン 縦分割    |
| `prefix \|` | ペイン 横分割    |
| `prefix e`  | ペイン同期トグル |

---

## ウィンドウ名の自動更新

ウィンドウ名は `カレントディレクトリ:実行中コマンド` の形式で常に自動更新されます
(`automatic-rename on`)。ステータスバーの `#I:#W` にそのまま反映されます。

| 状態                                   | ウィンドウ名の例 |
| -------------------------------------- | ---------------- |
| `~/git/kurage/dotfiles` でシェル       | `dotfiles:zsh`   |
| `~/git/kurage/dotfiles` で nvim 編集中 | `dotfiles:nvim`  |
| `~/git/aibs` で claude 実行中          | `aibs:claude`    |

:::note
`prefix ,` (rename-window) で手動命名すると、そのウィンドウだけ自動更新が停止します (tmux の標準挙動)。
:::

---

## ペイン移動

| キー  | 動作                                             |
| ----- | ------------------------------------------------ |
| `C-o` | ペイン順次移動                                   |
| `C-h` | 左ペイン / nvim 左 split へ (vim-tmux-navigator) |
| `C-j` | 下ペイン / nvim 下 split へ (vim-tmux-navigator) |
| `C-k` | 上ペイン / nvim 上 split へ (vim-tmux-navigator) |
| `C-\` | 右ペイン / nvim 右 split へ (vim-tmux-navigator) |

:::note
`C-l` はシェルの clear-screen のために解放しています。右移動は `C-\` を使ってください。
:::

:::caution
`C-h` / `C-j` / `C-k` はシェルアプリ (Claude CLI の改行、zsh の cdup 等) を妨げないよう root テーブルからは解放しています。vim からのナビゲーションは vim プラグインが tmux を直接操作するため正常に動作します。
:::

---

## ペインリサイズ

| キー  | 動作     |
| ----- | -------- |
| `M-→` | 右に拡大 |
| `M-←` | 左に拡大 |
| `M-↑` | 上に拡大 |
| `M-↓` | 下に拡大 |

---

## コピーモード (vi キーバインド)

| キー       | 動作                                  |
| ---------- | ------------------------------------- |
| `prefix [` | コピーモード開始                      |
| `v`        | 選択開始                              |
| `y`        | コピー & コピーモード終了 (pbcopy へ) |
| `Enter`    | コピー & コピーモード終了             |
| `q`        | コピーモード終了                      |

---

## マウス

マウス操作は有効です (`set -g mouse on`)。クリックでペイン選択、スクロールでコピーモードに入ります。

---

## プラグイン

| プラグイン                       | 機能                                           |
| -------------------------------- | ---------------------------------------------- |
| `tmux-plugins/tpm`               | プラグインマネージャ                           |
| `tmux-plugins/tmux-sensible`     | 基本設定の最適化                               |
| `tmux-plugins/tmux-resurrect`    | セッション保存・復元                           |
| `tmux-plugins/tmux-continuum`    | セッション自動保存 (15分ごと) / 起動時自動復元 |
| `tmux-plugins/tmux-open`         | ファイル / URL を開く                          |
| `tmux-plugins/tmux-cpu`          | CPU 使用率をステータスバーに表示               |
| `tmux-plugins/tmux-battery`      | バッテリー残量をステータスバーに表示           |
| `christoomey/vim-tmux-navigator` | nvim split と tmux pane をシームレスに移動     |
| `catppuccin/tmux`                | catppuccin mocha テーマ                        |

### TPM 操作

| キー           | 動作                   |
| -------------- | ---------------------- |
| `prefix I`     | プラグインインストール |
| `prefix U`     | プラグインアップデート |
| `prefix alt-u` | 不要なプラグインを削除 |
