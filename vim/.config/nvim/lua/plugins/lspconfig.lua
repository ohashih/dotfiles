local lsp_servers = {
  "pyright",
  "ruff",
  "bashls",
  "lua_ls",
  "yamlls",
  "jsonls",
  "taplo",
  "rust_analyzer",
  "ts_ls",
  "html",
  "cssls",
}

local formatters = {
    "djlint",
    "black",
    "isort",
    "stylua",
    "shfmt",
    "prettier",
}
local diagnostics = {
    "yamllint",
    "selene",
}

return {
  {
    "onsails/lspkind.nvim",
    event = "InsertEnter",
  },
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
      "jay-babu/mason-null-ls.nvim",
      "nvimtools/none-ls.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = lsp_servers,
      })

      local lsp_config = require("lspconfig")
      for _, lsp_server in ipairs(lsp_servers) do
        lsp_config[lsp_server].setup({
          root_dir = function(fname)
            return lsp_config.util.find_git_ancestor(fname) or vim.fn.getcwd()
          end,
        })
      end
    end,
    cmd = "Mason",
  },
  {
    "jay-babu/mason-null-ls.nvim",
    dependencies = {
        "williamboman/mason.nvim",
        "nvimtools/none-ls.nvim",
    },
  },
  {
    "nvimtools/none-ls.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      local null_ls = require("null-ls")
      local formatting_sources = {}
      for _, tool in ipairs(formatters) do
        table.insert(formatting_sources, null_ls.builtins.formatting[tool])
      end
      local diagnostics_sources = {}
      for _, tool in ipairs(diagnostics) do
        table.insert(diagnostics_sources, null_ls.builtins.diagnostics[tool])
      end
      null_ls.setup({
        diagnostics_format = "[#{m}] #{s} (#{c})",
        sources = vim.tbl_flatten({ formatting_sources, diagnostics_sources }),
      })
    end,
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "nvimdev/lspsaga.nvim",
    opts = {
      symbol_in_winbar = {
        separator = "  ",
      },
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    event = { "BufRead", "BufNewFile" },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
      dependencies = {
        "williamboman/mason.nvim",
        "mfussenegger/nvim-dap",
      },
      opts = {
        ensure_installed = {
          "python",
        },
      handlers = {},
    },
  },
}
