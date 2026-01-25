-- plugins/lspconfig.lua

return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
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
          "ts_ls",
        },
      })

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local on_attach = function(client, bufnr)
        local opts = { buffer = bufnr, noremap = true, silent = true }

        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.type_definition, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

        if client.server_capabilities.inlayHintProvider then
          vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end
      end

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

      -- フォーマッターとリンターのインストール
      require("mason-tool-installer").setup({
        ensure_installed = {
          "stylua",      -- Lua
          "prettier",    -- JS/TS/JSON/HTML/CSS
          "shfmt",       -- Shell
          "eslint_d",    -- JS/TS linter
        },
      })
    end,
  },
  
  -- フォーマッター管理
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>f",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          javascript = { "prettier" },
          typescript = { "prettier" },
          javascriptreact = { "prettier" },
          typescriptreact = { "prettier" },
          json = { "prettier" },
          html = { "prettier" },
          css = { "prettier" },
          markdown = { "prettier" },
          sh = { "shfmt" },
          bash = { "shfmt" },
          zsh = { "shfmt" },
        },
        -- 保存時に自動フォーマット
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
        -- shfmtの設定
        formatters = {
          shfmt = {
            prepend_args = { "-i", "2", "-ci" },
          },
        },
      })
    end,
  },

  -- リンター管理
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")
      
      lint.linters_by_ft = {
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
      }

      -- 自動リント実行
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
