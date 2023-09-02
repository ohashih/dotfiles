require("lint").linters_by_ft = {
  lua = { "luacheck" },
  markdown = { "markdownlint" },
}

-- file on save
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})