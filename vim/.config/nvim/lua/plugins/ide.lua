-- IDE 体験を底上げする周辺プラグイン群
return {
  -- 診断/参照を一覧する Problems パネル相当
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Trouble: Diagnostics (workspace)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Trouble: Diagnostics (buffer)" },
      { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Trouble: Symbols" },
      { "<leader>xr", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "Trouble: LSP references" },
      { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Trouble: Location list" },
      { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Trouble: Quickfix list" },
    },
    opts = {},
  },

  -- winbar のパンくず (VSCode のブレッドクラム)
  {
    "Bekaboo/dropbar.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-telescope/telescope-fzf-native.nvim" },
    config = function()
      local dropbar = require("dropbar")
      dropbar.setup({})
      vim.keymap.set("n", "<leader>;", function()
        require("dropbar.api").pick()
      end, { desc = "Dropbar: pick symbol" })
    end,
  },

  -- シンボルアウトライン (VSCode のアウトラインビュー)
  {
    "stevearc/aerial.nvim",
    cmd = { "AerialToggle", "AerialOpen" },
    keys = {
      { "<leader>cs", "<cmd>AerialToggle!<cr>", desc = "Aerial: Symbol outline" },
    },
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    opts = {
      backends = { "lsp", "treesitter", "markdown" },
      layout = { default_direction = "right" },
    },
  },

  -- 編集系 (autopairs/surround/flash) は plugins/editing.lua、
  -- セッション復元は plugins/productivity.lua に集約。

  -- nvim split と tmux pane をシームレスに移動 (tmux 側設定と対)
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<C-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Navigate left (nvim/tmux)" },
      { "<C-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Navigate down (nvim/tmux)" },
      { "<C-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Navigate up (nvim/tmux)" },
      { "<C-\\>", "<cmd>TmuxNavigateRight<cr>", desc = "Navigate right (nvim/tmux)" },
    },
  },
}
