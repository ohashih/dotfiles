return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter", -- InsertEnter イベントを追加
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
        copilot_node_command = "node",
      })
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    after = "copilot.lua", -- copilot.luaの後に読み込む
    config = function()
      require("copilot_cmp").setup()
    end,
  },
}
