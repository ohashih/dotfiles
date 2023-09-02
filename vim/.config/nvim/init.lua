require 'option'
require 'keymap'
require 'color'
require 'plugins'

require('tabline').setup()
require('indent_blankline').setup {
  show_end_of_line = true,
  space_char_blankline = ' ',
}
vim.cmd [[autocmd BufWritePost plugins.lua PackerCompile]]
