-- 生産性向上系: TODOハイライト / セッション復元 / 構文単位の textobject
return {
  -- TODO/FIXME/HACK/BUG 等のコメントを強調し、一覧・ジャンプ可能にする
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    keys = {
      { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Search todos" },
      { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todos (Trouble)" },
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Prev todo comment" },
    },
  },

  -- ディレクトリ単位でバッファ/レイアウトを保存・復元
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
    keys = {
      { "<leader>Ss", function() require("persistence").load() end, desc = "Restore session" },
      { "<leader>Sl", function() require("persistence").load({ last = true }) end, desc = "Restore last session" },
      { "<leader>Sd", function() require("persistence").stop() end, desc = "Don't save session" },
    },
  },

  -- 関数/クラス等の構文単位の選択・移動 (vaf, ]f など)
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-treesitter.configs").setup({
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
            goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
          },
        },
      })
    end,
  },
}
