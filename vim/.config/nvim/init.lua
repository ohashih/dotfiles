vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("core.options")
require("core.lazy")
vim.cmd([[colorscheme tokyonight-storm]])
vim.cmd([[autocmd BufWritePost plugins.lua PackerCompile]])
require("core.keymaps")
require("core.autocmd")
