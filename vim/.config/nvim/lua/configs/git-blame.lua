require("gitblame").setup({
  init = function()
    vim.g.gitblame_enabled = 0
    vim.g.gitblame_display_virtual_text = 0
  end,
})
