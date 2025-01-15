local M = {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "zbirenbaum/copilot-cmp",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "saadparwaiz1/cmp_luasnip",
    "L3MON4D3/LuaSnip",
  },
  event = { "InsertEnter", "CmdlineEnter" },
}

local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
    return false
  end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end

M.config = function()
  local cmp = require("cmp")
  local lspkind = require("lspkind")
  vim.opt.completeopt = { "menu", "menuone", "noselect" }

  cmp.setup({
    formatting = {
      format = lspkind.cmp_format({
        mode = "symbol",
        maxwidth = 50,
        ellipsis_char = "...",
        before = function(entry, vim_item)
          return vim_item
        end,
      }),
    },
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-t>"] = cmp.mapping.complete(),
      ["<C-f>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
      { name = "nvim_lsp",        keyword_length = 1, priority = 1000 },
      { name = "copilot",         keyword_length = 2, priority = 600 },
      { name = "render-markdown", keyword_length = 2, priority = 300 },
      { name = "nvim_lua",        keyword_length = 3, priority = 400 },
      { name = "luasnip",         keyword_length = 2, priority = 200 },
    }, {
      -- {
      --   name = "buffer",
      --   keyword_length = 3,
      --   priority = 700,
      --   option = {
      --     get_bufnrs = function()
      --       return vim.api.nvim_list_bufs()
      --     end,
      --   },
      -- },
      { name = "path",    keyword_length = 2, priority = 100 },
      { name = "cmdline", keyword_length = 3, priority = 500 },
    }),
    experimental = {
      native_menu = false,
      ghost_text = false,
    },
  })

  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "path" },
    }, {
      { name = "cmdline" },
    }),
  })
end

return M
