-- 追加の編集ツール: バッファ式ファイラ / リファクタリング操作
return {
  -- ファイルシステムをバッファとして編集 (- で親dirへ, 一括リネーム可)
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    opts = {},
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "Open parent directory (Oil)" },
    },
  },

  -- 変数抽出・関数抽出などのリファクタリング操作
  {
    "ThePrimeagen/refactoring.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "lewis6991/async.nvim",
    },
    opts = {},
    keys = {
      { "<leader>Re", function() require("refactoring").refactor("Extract Function") end, mode = "x", desc = "Extract function" },
      { "<leader>Rv", function() require("refactoring").refactor("Extract Variable") end, mode = "x", desc = "Extract variable" },
      { "<leader>Ri", function() require("refactoring").refactor("Inline Variable") end, mode = { "n", "x" }, desc = "Inline variable" },
      { "<leader>Rb", function() require("refactoring").refactor("Extract Block") end, mode = "n", desc = "Extract block" },
    },
  },
}
