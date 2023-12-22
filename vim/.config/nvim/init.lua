require("option")
require("keymap")
require("color")
require("plugins")

require("tabline").setup()
vim.cmd([[autocmd BufWritePost plugins.lua PackerCompile]])
