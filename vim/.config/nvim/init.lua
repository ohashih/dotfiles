vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("core.options")
require("core.lazy")
vim.cmd([[colorscheme catppuccin]])
-- vim.cmd("colorscheme rose-pine-main")
vim.cmd([[autocmd BufWritePost plugins.lua PackerCompile]])
require("core.keymaps")
require("core.autocmd")
