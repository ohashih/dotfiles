require("plugins")
require("option")
require("keymap")
require("color")

require("tabline").setup()
vim.cmd([[autocmd BufWritePost plugins.lua PackerCompile]])
