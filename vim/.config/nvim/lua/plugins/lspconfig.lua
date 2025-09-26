-- plugins/lspconfig.lua

return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "nvimtools/none-ls.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "rshkarin/mason-nvim-lint",
    },
    config = function()
      require("mason").setup()

      -- LSP サーバー自動インストール
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
      }

      for _, server in ipairs(servers) do
        lspconfig[server].setup({
          capabilities = capabilities,
        })
      end

      -- none-ls 設定
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.prettier,
        },
      })

      -- mason-tool-installer で自動インストールするツールを指定
      require("mason-tool-installer").setup({
        ensure_installed = {
          "stylua",
          "prettier",
          "eslint_d",
        },
      })

      -- mason-nvim-lint 設定
      require("mason-nvim-lint").linters_by_ft = {
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        lua = { "luacheck" },
      }

      -- 保存時に lint 実行
      -- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      --   callback = function()
      --     require("mason-nvim-lint").try_lint()
      --   end,
      -- })
    end,
  },
}
