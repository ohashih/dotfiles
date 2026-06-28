-- plugins/lspconfig.lua

return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile", "VeryLazy" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
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
          "pyright",
          "yamlls",
          "taplo",
        },
        -- サーバは下の vim.lsp.enable(servers) で明示的に有効化するため、
        -- mason 導入物 (stylua --lsp 等の非 LSP も含む) の自動有効化を無効にする。
        automatic_enable = false,
      })

      local capabilities = require("blink.cmp").get_lsp_capabilities()

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
        "pyright",
        "yamlls",
        "taplo",
      }

      for _, server in ipairs(servers) do
        vim.lsp.config(server, {
          capabilities = capabilities,
        })
      end

      vim.lsp.enable(servers)

      -- Diagnostic表示設定 (signs アイコンもここへ集約。neo-tree 側の重複定義は削除済み)
      vim.diagnostic.config({
        virtual_text = { spacing = 2, prefix = "●" },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.INFO] = " ",
            [vim.diagnostic.severity.HINT] = "󰌵",
          },
        },
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          border = "rounded",
          source = true,
        },
      })

      require("mason-tool-installer").setup({
        ensure_installed = {
          "stylua",
          "prettier",
          "shfmt",
          "eslint_d",
          "terraform-ls",
          "tflint",
          "black",
          "ruff",
          "yamllint",
          "taplo",
        },
      })
    end,
  },

  -- Lspsaga
  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("lspsaga").setup({})
    end,
  },

  -- フォーマッター管理
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    keys = {
      {
        "<Space><Space>",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "n",
      },
    },
    cmd = { "ConformInfo" },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          javascript = { "prettier" },
          typescript = { "prettier" },
          javascriptreact = { "prettier" },
          typescriptreact = { "prettier" },
          jsx = { "prettier" },
          tsx = { "prettier" },
          json = { "prettier" },
          html = { "prettier" },
          css = { "prettier" },
          markdown = { "prettier" },
          sh = { "shfmt" },
          bash = { "shfmt" },
          zsh = { "shfmt" },
          terraform = { "terraform_fmt" },
          tf = { "terraform_fmt" },
          ["terraform-vars"] = { "terraform_fmt" },
          python = { "black" },
          yaml = { "prettier" },
          toml = { "taplo" },
          rust = { "rustfmt" },
        },
        -- 保存時に自動フォーマット
        format_on_save = false,
        -- shfmtの設定
        formatters = {
          shfmt = {
            prepend_args = { "-i", "4", "-ci", "-sr" },
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
        jsx = { "eslint_d" },
        tsx = { "eslint_d" },
        terraform = { "tflint" },
        tf = { "tflint" },
        python = { "ruff" },
        yaml = { "yamllint" },
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
