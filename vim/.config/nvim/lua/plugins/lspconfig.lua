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
      "glepnir/lspsaga.nvim",
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
          "ts_ls", -- tsserver renamed
        },
      })

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- on_attach: keymaps + inlay hints
      local on_attach = function(client, bufnr)
        local opts = { buffer = bufnr, noremap = true, silent = true }

        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.type_definition, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

        -- Neovim 標準 InlayHints API
        if client.server_capabilities.inlayHintProvider then
          vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end
      end

      -- ✅ 新しいAPIでLSPを設定
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
        vim.lsp.config(server, {
          capabilities = capabilities,
          on_attach = on_attach,
        })
      end

      -- ✅ Masonツール設定
      require("mason-tool-installer").setup({
        ensure_installed = {
          "stylua",
          "prettier",
          "eslint_d",
        },
      })

      -- ✅ null-ls 設定
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.prettier,
        },
      })

      -- ✅ linter設定
      require("mason-nvim-lint").linters_by_ft = {
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        lua = { "luacheck" },
      }
    end,
  },
}
