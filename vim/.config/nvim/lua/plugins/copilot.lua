return {
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    lazy = true,
    opts = { suggestion = { enabled = false }, panel = { enabled = false }, copilot_node_command = "node" },
    config = function()
      require("copilot").setup()
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    event = "InsertEnter",
    lazy = true,
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end,
  },
}
