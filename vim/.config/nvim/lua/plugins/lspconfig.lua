
-- plugins/lspconfig.lua

return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "nvimtools/none-ls.nvim",
      "jay-babu/mason-null-ls.nvim",
    },
    config = function()
      require("mason").setup()

      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "rust_analyzer",
          "jsonls",
          "bashls",
          "html",
          "cssls",
          "tailwindcss",
          "ts_ls",
          "terraformls",
        },
      })

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local lspconfig = require("lspconfig")
      local servers = {
        "lua_ls",
        "rust_analyzer",
        "jsonls",
        "bashls",
        "html",
        "cssls",
        "tailwindcss",
        "ts_ls",
        "terraformls",
      }

      for _, server in ipairs(servers) do
        lspconfig[server].setup({
          capabilities = capabilities,
        })
      end

      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.formatting.terraform_fmt,
        },
      })

      -- mason-null-ls 設定
      require("mason-null-ls").setup({
        ensure_installed = {
          "prettier",
          "stylua",
          "eslint",
          "golangci-lint",
          "terraform_fmt",
        },
        automatic_installation = true,
      })
    end,
  },
}
