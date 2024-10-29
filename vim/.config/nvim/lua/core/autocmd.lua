local vim = vim

-- ファイル保存時に自動フォーマット
vim.api.nvim_create_augroup("LspFormatOnSave", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
  group = "LspFormatOnSave",
  pattern = "*",
  callback = function()
    print("Auto-formatting triggered")
    vim.lsp.buf.format({
      async = false,
      filter = function(client)
        return client.name == "null-ls"
      end,
      bufnr = vim.api.nvim_get_current_buf(),
    })
  end,
})
