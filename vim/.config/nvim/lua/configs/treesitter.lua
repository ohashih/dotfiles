local M = {}

require("nvim-treesitter").setup({
  auto_install = true,
  highlight = {
    enable = true,
  },
  autotag = {
    enable = true,
  },
})

return M
