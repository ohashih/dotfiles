local on_attach = function(client, bufnr)
  client.server_capabilities.documentFormattingProvider = false

  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- -- Mappings.
  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set('n', 'rn', vim.lsp.buf.rename, bufopts)

  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  --  vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
  --    vim.lsp.buf.format()
  --  end, { desc = "Format current buffer with LSP" })
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('mason').setup()
require('mason-lspconfig').setup()
require('mason-lspconfig').setup_handlers {
  function(server_name) -- default handler (optional)
    require('lspconfig')[server_name].setup {
      on_attach = on_attach,
      capabilities = capabilities,
    }
  end,
}

-- Diagnostic symbols in the sign column
local signs = { Error = ' ', Warn = '>>', Hint = '>', Info = '>' }
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
end

-- LSP-Diagnostic Settings(LSP-Handler)
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = { spacing = 2, prefix = '◆', severity = 'Error' },
  severity_sort = true,
  underline = true,
  update_in_insert = false,
})

-- Diagnostic Setting(Gloabal)
vim.diagnostic.config {
  virtual_text = { spacing = 2, prefix = '◆', severity = 'Error' },
  severity_sort = true,
  underline = true,
  update_in_insert = false,
  float = {
    source = 'always', -- Or "if_many"
  },
}

-- linter
--vim.api.nvim_create_autocmd({ "BufWritePost" }, {
--  callback = function()
--    require("lint").try_lint()
--  end,
--})

--require("lint").linters.markdownlint = {
--  cmd = "markdonwlint",
--  stdin = true, -- or false if it doesn't support content input via stdin. In that case the filename is automatically added to the arguments.
--  append_fname = true, -- Automatically append the file name to `args` if `stdin = false` (default: true)
--  args = {}, -- list of arguments. Can contain functions with zero arguments that will be evaluated once the linter is used.
--  stream = nil, -- ('stdout' | 'stderr' | 'both') configure the stream to which the linter outputs the linting result.
--  ignore_exitcode = false, -- set this to true if the linter exits with a code != 0 and that's considered normal.
--  env = nil, -- custom environment table to use with the external process. Note that this replaces the *entire* environment, it is not additive.
--}

local status, nvim_lsp = pcall(require, 'lspconfig')
if not status then
  return
end

-- TypeScript
nvim_lsp.tsserver.setup {
  on_attach = on_attach,
  filetypes = { 'typescript', 'typescriptreact', 'typescript.tsx' },
  cmd = { 'typescript-language-server', '--stdio' },
}

nvim_lsp.marksman.setup {
  on_attach = on_attach,
  filetypes = { 'markdown', 'md' },
}

nvim_lsp.cssls.setup {
  on_attach = on_attach,
  filetypes = { 'css', 'scss' },
}

nvim_lsp.html.setup {
  on_attach = on_attach,
  filetypes = { 'html' },
}

nvim_lsp.lua_ls.setup {
  on_attach = on_attach,
  filetypes = { 'lua' },
}

nvim_lsp.elixirls.setup {
  on_attach = on_attach,
  flietypes = { 'ex' },
}
