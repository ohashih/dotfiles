---
title: Neovim キーバインド
description: Neovim の全キーバインド一覧
sidebar:
  order: 1
---

## Leader キー

`Space` がリーダーキーです。

---

## 基本操作

| キー | モード | 動作 |
|------|--------|------|
| `jj` | Insert | Normal モードへ戻る |
| `Esc Esc` | Normal | 検索ハイライト解除 |
| `C-s` | Normal / Insert | 保存 |
| `C-q` | Normal / Insert | 強制終了 |
| `j` / `k` | Normal / Visual | 折り返し行単位移動 |
| `Y` | Normal | 行末までヤンク |
| `x` | Normal | ヤンクなし削除 |
| `dw` | Normal | 単語後退削除 |
| `Space h` | Normal | 行頭へ |
| `Space l` | Normal | 行末へ |
| `Space q` | Normal | 強制終了 |
| `me` | Normal | メモファイルを開く |

### Insert モード カーソル移動

| キー | 動作 |
|------|------|
| `C-h` | 左 |
| `C-l` | 右 |
| `C-j` | 下 |
| `C-k` | 上 |
| `C-f` | 右 |
| `C-b` | 左 |
| `C-d` | Delete |

---

## ウィンドウ / タブ / バッファ

| キー | 動作 |
|------|------|
| `C-h` / `C-j` / `C-k` / `C-\` | vim-tmux-navigator: split / pane 移動 |
| `S-j` | 水平分割 |
| `S-l` | 垂直分割 |
| `Tab` | 次のバッファ |
| `S-Tab` | 前のバッファ |
| `C-c` | 現在のバッファを閉じる |
| `Space a` | 全バッファを削除 |
| `te` | タブ編集 (`:tabedit`) |
| `t` | 新規タブ |

---

## LSP

| キー | 動作 |
|------|------|
| `gd` | 定義へジャンプ |
| `gD` | 宣言へジャンプ |
| `gi` | 実装へジャンプ |
| `gr` | 参照一覧 |
| `K` | ホバードキュメント |
| `C-k` | シグネチャヘルプ |
| `leader rn` | リネーム |
| `leader D` | 型定義へ |
| `space ca` | コードアクション |
| `leader e` | 診断フロート表示 |
| `[d` / `]d` | 前 / 次の診断へ |
| `leader q` | 診断を loclist へ |
| `leader ih` | Inlay hints トグル |
| `Space Space` | フォーマット (conform.nvim) |

### Lspsaga

| キー | 動作 |
|------|------|
| `leader lf` | Finder (参照表示) |
| `leader lh` | Hover Doc |
| `leader lo` | アウトライン |
| `leader lr` | リネーム |
| `leader la` | コードアクション |

---

## Telescope

| キー | 動作 |
|------|------|
| `leader f` | ファイル検索 |
| `leader r` | 全文検索 (ripgrep) |
| `leader b` | バッファ一覧 |
| `leader o` | 診断一覧 |
| `leader h` | ヘルプタグ |
| `leader gc` | Git コミット履歴 |
| `leader fb` | ファイルブラウザ |

---

## Trouble (Problems パネル)

| キー | 動作 |
|------|------|
| `leader xx` | Workspace 診断 |
| `leader xX` | バッファ診断 |
| `leader xs` | シンボル一覧 |
| `leader xr` | LSP 参照 |
| `leader xl` | Location list |
| `leader xq` | Quickfix list |

---

## DAP (デバッガ)

| キー | 動作 |
|------|------|
| `F5` | 実行 / 続行 |
| `F10` | ステップオーバー |
| `F11` | ステップイン |
| `F12` | ステップアウト |
| `leader db` | ブレークポイント トグル |
| `leader dB` | 条件付きブレークポイント |
| `leader dr` | REPL トグル |
| `leader dl` | 最後の実行を再実行 |
| `leader dt` | デバッグ終了 |
| `leader du` | DAP UI トグル |
| `leader de` | 式を評価 |

---

## AI 連携

### claudecode.nvim (Claude Code CLI)

| キー | 動作 |
|------|------|
| `leader ac` | Claude Code トグル |
| `leader af` | Claude Code フォーカス |
| `leader ar` | Claude Code 再開 |
| `leader aC` | Claude Code 続きから |
| `leader ab` | 現在のバッファを追加 |
| `leader as` | 選択範囲を送信 (Visual) |
| `leader ay` | diff を承認 |
| `leader an` | diff を拒否 |

### CodeCompanion (Anthropic API)

| キー | 動作 |
|------|------|
| `leader cc` | チャット トグル |
| `leader cp` | アクション一覧 |
| `leader ci` | インライン補完 |

---

## IDE 機能

| キー | 動作 |
|------|------|
| `leader ;` | Dropbar: パンくず選択 |
| `leader cs` | Aerial: シンボルアウトライン |
| `s` | Flash: ジャンプ |
| `S` | Flash: Treesitter ジャンプ |
| `C-s` (Command mode) | Flash: 検索トグル |

### セッション (persistence.nvim)

| キー | 動作 |
|------|------|
| `leader qs` | カレントディレクトリのセッション復元 |
| `leader ql` | 最後のセッション復元 |
| `leader qd` | セッション保存を停止 |

### nvim-surround

| キー | 動作 |
|------|------|
| `ys{motion}{char}` | サラウンド追加 |
| `ds{char}` | サラウンド削除 |
| `cs{old}{new}` | サラウンド変更 |

---

## Git

| キー | 動作 |
|------|------|
| `leader df` | Diffview 開く |
| `leader dc` | Diffview 閉じる |
| `leader dh` | ファイル履歴 |
| `leader db` | Git blame トグル |

---

## NeoTree

| キー | 動作 |
|------|------|
| `C-n` | NeoTree トグル |

---

## Noice

| キー | 動作 |
|------|------|
| `leader ma` | 全メッセージ表示 |
| `leader mh` | 履歴表示 |
| `leader me` | エラー表示 |

---

## blink.cmp (補完)

| キー | 動作 |
|------|------|
| `Tab` | 候補選択 / 次へ |
| `S-Tab` | 前の候補へ |
| `C-n` | 補完候補を表示 |
| `C-f` / `Enter` | 候補を確定 |
| `C-e` | 補完を閉じる |
