---
title: zsh キーバインド
description: zsh (sheldon 管理) のキーバインド一覧
sidebar:
  order: 2
---

## プラグイン管理

zsh プラグインは [sheldon](https://sheldon.cli.rs/) で管理しています。設定は `~/.config/sheldon/plugins.toml`。

---

## キーバインド一覧

| キー | 動作 |
|------|------|
| `C-l` | 画面クリア (clear-screen) |
| `C-r` | fzf 履歴検索 |
| `C-p` | 入力中の文字列で履歴検索 (前) |
| `C-n` | 入力中の文字列で履歴検索 (次) |
| `↑` / `↓` | history-substring-search (入力文字列で絞り込み) |
| `C-k` | 一階層上へ移動 (`cd ..`) |
| `C-h` | Insert: 左 *(vim-tmux-navigator が奪うため tmux 外のみ)* |

---

## 補完 (Tab メニュー選択)

`Tab` で補完候補をメニュー表示し、矢印キー等で選択できます (`menu select` / `auto_menu`)。

| キー | 動作 |
|------|------|
| `Tab` | 1回目: 候補一覧を表示 / 2回目以降: 次の候補へ循環 |
| `S-Tab` | 前の候補へ (逆順, reverse-menu-complete) |
| `↑` / `↓` / `←` / `→` | メニュー内で候補を選択 |
| `Enter` | 選択中の候補を確定 |

### cd 補完

`cd` の補完では `cdpath` (`~/git/kurage` 等) の中身を常時表示しないよう
tag-order を制御しています。ローカルにマッチが無い場合のみ `cdpath` 由来の候補を表示します。
リポジトリ名だけで移動する機能 (`cd <repo>`) は従来どおり利用できます (`~/.zsh/cdpath.zshrc`)。

---

## zoxide (スマート cd)

| コマンド | 動作 |
|----------|------|
| `z <dir>` | 履歴から推測して cd |
| `zi` | fzf でディレクトリ選択して cd |
| `z -` | 直前のディレクトリへ |

---

## fzf 連携

| キー / コマンド | 動作 |
|-----------------|------|
| `C-r` | fzf でコマンド履歴検索 |
| `zi` | zoxide + fzf でディレクトリジャンプ |

カラーテーマは catppuccin mocha に統一しています (`~/.zsh/fzf.zshrc`)。

---

## 注意事項

tmux セッション内では `C-h` / `C-j` / `C-k` が vim-tmux-navigator に割り当てられているため、シェル側には届きません。ペイン移動には `C-o`（順次）または tmux prefix + 矢印キーを使ってください。
