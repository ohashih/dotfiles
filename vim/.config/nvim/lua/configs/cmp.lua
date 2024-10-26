local cmp = require("cmp")
cmp.setup({
      sources = {
    { name = 'cmp-nvim-lsp', keyword_length = 1 },
    { name = 'copilot' },
    { name = 'cm-buffer', keyword_length = 2 },
    { name = 'cmp-path' },
    { name = 'cmp-cmdline' },
    { name = 'vim-vsnip' },
    { name = 'cmp-vsnip' },
    { name = 'lspkind' },
    { name = 'lspsaga' },
  }
})

