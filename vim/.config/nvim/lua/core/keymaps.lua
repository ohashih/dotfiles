-- keymap https://neovim.io/doc/user/intro.html#key-notation
local vim = vim
local opts = { noremap = true, silent = true }

--local keymap = vim.keymap
local keymap = vim.api.nvim_set_keymap

--desc,bufferなどを追加するオプション
local function ex_opts(desc, buffer)
  local final_opts = vim.tbl_extend("force", opts, {})
  if desc then
    final_opts.desc = desc
  end
  if buffer then
    final_opts.buffer = buffer
  end
  return final_opts
end

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

-- ESC でハイライトやめる
keymap("n", "<Esc><Esc>", ":noh<CR>", ex_opts("Rest Hightlight Search"))

-- buffer
keymap("n", "<tab>", ":bnext<CR>", opts)
keymap("n", "<S-tab>", ":bprev<CR>", opts)
keymap("n", "<C-c>", ":bd %<CR>:bprev<CR>", opts)
keymap("n", "<Space>a", ":%bdelete<CR>", opts)

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
keymap("n", "<C-s>", ":w<CR>", ex_opts("Save"))
keymap("n", "<C-q>", ":q!<CR>", ex_opts("Quit"))
keymap("i", "<C-s>", "<ESC>:w<CR>", ex_opts("Save"))
keymap("i", "<C-q>", "<ESC>:q!<CR>", ex_opts("Quit"))

-- 折り返し時に行単位移動
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)
keymap("v", "j", "gj", opts)
keymap("v", "k", "gk", opts)

-- Plugins
-- Noice
keymap("n", "<leader>ma", ":NoiceAll<CR>", ex_opts("Noice all"))
keymap("n", "<leader>mh", ":NoiceHistory<CR>", ex_opts("Noice history"))
keymap("n", "<leader>me", ":NoiceErrors<CR>", ex_opts("Noice error"))

-- git
keymap("n", "<leader>df", ":DiffviewOpen<CR>", ex_opts("DiffviewOpen"))
keymap("n", "<leader>dc", ":DiffviewClose<CR>", ex_opts("DiffviewClose"))
keymap("n", "<leader>dh", ":DiffviewFileHistory<CR>", ex_opts("DiffviewFileHistory"))
keymap("n", "<leader>db", ":GitBlameToggle<CR>", opts)

-- NeoTree
keymap("n", "<C-n>", ":Neotree toggle<CR>", opts)

-- lsp
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- バッファローカルでのLSP設定
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
    -- バッファローカルなキーマッピング
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, ex_opts("Go to declaration", ev.buf))
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, ex_opts("Go to definition", ev.buf))
    vim.keymap.set("n", "K", vim.lsp.buf.hover, ex_opts("Hover", ev.buf))
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, ex_opts("Go to implementation", ev.buf))
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, ex_opts("Signature help", ev.buf))
    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, ex_opts("Add workspace folder", ev.buf))
    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, ex_opts("Remove workspace folder", ev.buf))
    vim.keymap.set("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, ex_opts("List workspace folders", ev.buf))
    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, ex_opts("Go to type definition", ev.buf))
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, ex_opts("Rename", ev.buf))
    vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, ex_opts("Code action", ev.buf))
    vim.keymap.set("n", "gr", vim.lsp.buf.references, ex_opts("References", ev.buf))
    vim.keymap.set("n", "<leader><space>", function()
      vim.lsp.buf.format({ async = true })
    end, ex_opts("Format", ev.buf))

    -- Diagnostic mappings
    vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, ex_opts("Open diagnostic float", ev.buf))
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, ex_opts("Go to previous diagnostic", ev.buf))
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, ex_opts("Go to next diagnostic", ev.buf))
    vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, ex_opts("Set diagnostic loclist", ev.buf))

    -- Lspsaga キーマッピング
    vim.keymap.set("n", "<leader>lf", "<cmd>Lspsaga finder<cr>", ex_opts("Lspsaga Finder show references", ev.buf))
    vim.keymap.set("n", "<leader>lh", "<cmd>Lspsaga hover_doc<cr>", ex_opts("Lspsaga Hover Doc", ev.buf))
    vim.keymap.set("n", "<leader>lo", "<cmd>Lspsaga outline<cr>", ex_opts("Lspsaga Outline", ev.buf))
    vim.keymap.set("n", "<leader>lr", "<cmd>Lspsaga rename<cr>", ex_opts("Lspsaga Rename", ev.buf))
    vim.keymap.set("n", "<leader>la", "<cmd>Lspsaga code_action<cr>", ex_opts("Lspsaga Code Action", ev.buf))
  end,
})
