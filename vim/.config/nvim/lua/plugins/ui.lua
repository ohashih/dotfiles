return {
  --Color
  {
    "catppuccin/nvim", name = "catppuccin",
    lazy = false,
    priority = 1000,
  },
  -- hightlight
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "UIEnter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    opts = {
      highlight = { enable = true },
      auto_install = false,
      ensure_installed = "all",
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["ab"] = "@block.outer",
            ["ib"] = "@block.inner",
            ["al"] = "@call.outer",
            ["il"] = "@call.inner",
            ["aP"] = "@parameter.outer",
            ["iP"] = "@parameter.inner",
            ["ao"] = "@conditional.outer",
            ["io"] = "@conditional.inner",
            ["as"] = "@statement.outer",
          },
        },
      },
    },
  },
  {
    "shellRaining/hlchunk.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("hlchunk").setup({
        chunk = {
          enable = true,
          use_treesitter = true,
          notify = true,
        },
        indent = {
          enable = true,
          chars = { "│" },
        },
      })
    end,
  },
  --trailing space
  {
    "bronson/vim-trailing-whitespace",
  },
  -- yank highlight
  {
    "machakann/vim-highlightedyank",
    lazy = true, -- 遅延読み込みを有効に
    event = "TextYankPost", -- ヤンクイベントが発生したときに読み込む
    config = function()
      -- ハイライトの設定
      vim.g.highlightedyank_highlight_duration = 300 -- ハイライトが表示される時間（ミリ秒）

      -- ヤンク後のハイライト
      vim.api.nvim_exec(
        [[
        augroup highlight_yank
          autocmd!
          autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=300}
        augroup END
      ]],
        false
      )
    end,
  },
  -- scroll smooth
  {
    "karb94/neoscroll.nvim",
    lazy = true,
    config = function()
      require("neoscroll").setup()
    end,
  },
  -- auto-pairs
  --[[ {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    lazy = true,
    config = function()
      require("nvim-autopairs").setup()
    end,
  }, ]]
}
