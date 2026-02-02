return {
  {
    "nvim-pack/nvim-spectre",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>S", '<cmd>lua require("spectre").open()<CR>', desc = "Spectre: Search/Replace (Project)" },
      { "<leader>sw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', desc = "Spectre: Search current word" },
      { "<leader>sw", '<cmd>lua require("spectre").open_visual()<CR>', mode = "v", desc = "Spectre: Search selection" },
      { "<leader>sf", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', desc = "Spectre: Search current file" },
    },
    config = function()
      require("spectre").setup({})
    end,
  },
}
