return {
  -- amongst your other plugins
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        direction = "horizontal",
        size = 20,
        open_mapping = [[<c-\>]],
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
      })
    end,
  },
}
