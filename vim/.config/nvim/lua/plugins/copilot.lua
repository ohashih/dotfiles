-- Copilot: インライン補完ソースとして利用 (補完は blink-copilot 経由で cmp.lua に統合)
-- チャット/エージェント系は Claude 中心に再編したため ai.lua (codecompanion / claudecode) を参照。
return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
        copilot_node_command = "node",
      })
    end,
  },
}
