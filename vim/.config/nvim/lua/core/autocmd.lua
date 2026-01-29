local vim = vim

-- yank highlight
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 300 })
  end,
})

-- ファイル保存時に自動フォーマット

-- vim.api.nvim_create_augroup("LspFormatOnSave", { clear = true })
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   group = "LspFormatOnSave",
--   pattern = "*",
--   callback = function()
--     print("Auto-formatting triggered")
--     vim.lsp.buf.format({
--       async = false,
--       filter = function(client)
--         return client.name == "null-ls"
--       end,
--       bufnr = vim.api.nvim_get_current_buf(),
--     })
--   end,
-- })
-- 保存時にトレーリングスペースを削除
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.sh", "*.bash", "*.zsh" },
  callback = function()
    -- トレーリングスペースを削除
    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end,
})
