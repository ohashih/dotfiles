return {
  "nvim-telescope/telescope-file-browser.nvim",
  dependencies= {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim"
  },
  keys = {
    { "<leader>r", "<cmd>Telescope live_grep<CR>", { silent = true, noremap = true, desc = "ripGrep" } },
    { "<leader>b", "<cmd>Telescope buffers<CR>", { silent = true, noremap = true, desc = "buffers" } },
    { "<leader>o", "<cmd>Telescope diagnostics<CR>", { silent = true, noremap = true, desc = "diagnosticses" } },
    { "<leader>h", "<cmd>Telescope help_tags<CR>", { silent = true, noremap = true, desc = "helps" } },
  },
 }
