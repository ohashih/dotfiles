-- モダンな編集体験を補う軽量プラグイン群
-- autopairs: 括弧/クォートの自動補完, surround: 囲み操作, flash: 高速ジャンプ
return {
  -- 括弧・クォートの自動閉じ (blink.cmp と共存。確定時の () 挿入も扱う)
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,
      ts_config = { lua = { "string" }, javascript = { "template_string" } },
    },
  },

  -- ys/cs/ds による囲み操作 (例: ysiw" で単語を " で囲む)
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },

  -- 2文字ラベルジャンプ。s で前方/後方どこへでも飛ぶ
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      -- S はビジュアルモードでは nvim-surround に譲る (n/o のみ)
      { "S", mode = { "n", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },
}
