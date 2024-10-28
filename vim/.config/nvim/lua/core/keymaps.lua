-- keymap https://neovim.io/doc/user/intro.html#key-notation

local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

--local keymap = vim.keymap
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = 'n',
--   insert_mode = 'i',
--   visual_mode = 'v',
--   visual_block_mode = 'x',
--   term_mode = 't',
--   command_mode = 'c',

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- New tab
keymap("n", "te", ":tabedit", opts)
-- 新しいタブを一番右に作る
keymap("n", "t", ":tabnew<Return>", opts)
-- Split window
keymap("n", "<S-j>", ":split<Return><C-w>w", opts)
keymap("n", "<S-l>", ":vsplit<Return><C-w>w", opts)
-- Do not yank with x
keymap("n", "x", '"_x', opts)

-- Delete a word backwards
keymap("n", "dw", 'vb"_d', opts)

-- 行の端に行く
keymap("n", "<Space>h", "^", opts)
keymap("n", "<Space>l", "$", opts)

-- 行末までのヤンクにする
keymap("n", "Y", "y$", opts)

-- <Space>q で強制終了
keymap("n", "<Space>q", ":<C-u>q!<Return>", opts)

-- ESC*2 でハイライトやめる
keymap("n", "<Esc><Esc>", ":<C-u>set nohlsearch<Return>", opts)

-- buffer
keymap("n", "<tab>", ":bnext<CR>", opts)
keymap("n", "<S-tab>", ":bprev<CR>", opts)
keymap("n", "<C-c>", ":bd %<CR>:bprev<CR>", opts)
keymap("n", "<Space>a", ":%bdelete<CR>", opts)

-- NeoTree
keymap("n", "<C-n>", ":Neotree toggle<CR>", opts)

-- DiffviewOpen

keymap("n", "<leader>g", ":DiffviewOpen<CR>", opts)
keymap("n", "gb", ":GitBlameToggle<CR>", opts)

-- Select all
-- keymap("n", "<C-a>", "gg<S-v>G", opts)

-- private memo

keymap("n", "me", ":e ~/admin/memo.md<CR>", opts)

-- Insert --
-- Press jk fast to exit insert mode
keymap("i", "jj", "<ESC>", opts)
-- move at insert mode
keymap("i", "<C-d>", "<Del>", opts)
keymap("i", "<C-h>", "<Left>", opts)
keymap("i", "<C-j>", "<Down>", opts)
keymap("i", "<C-k>", "<Up>", opts)
keymap("i", "<C-l>", "<Right>", opts)
keymap("i", "<C-f>", "<Right>", opts)
keymap("i", "<C-b>", "<Left>", opts)

-- コンマの後に自動的にスペースを挿入
-- keymap("i", ",", ",<Space>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
-- ビジュアルモード時vで行末まで選択
keymap("v", "v", "$h", opts)
-- 0番レジスタを使いやすくした
keymap("v", "<C-p>", '"0p', opts)


-- others
-- save
keymap("n", "<C-s>", ":w<CR>", opts)
keymap("n", "<C-q>", ":q!<CR>", opts)
keymap("i", "<C-s>", "<ESC>:w<CR>", opts)
keymap("i", "<C-q>", "<ESC>:q!<CR>", opts)

-- 折り返し時に行単位移動
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)
keymap("v", "j", "gj", opts)
keymap("v", "k", "gk", opts)


