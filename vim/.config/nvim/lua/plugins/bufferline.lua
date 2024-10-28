return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-tree/nvim-web-devicons"
  },
  opts = {
    options = {
      mode = buffers,
      separator_style = "slant",
      always_show_bufferline = false,
      show_buffer_close_icons = false,
      show_close_icon = false,
      color_icons = true,
    },
    highlights = {
      separator = {
        guifg = "#073642",
        guibg = "#002b36",
      },
      separator_selected = {
        guifg = "#073642",
      },
      background = {
        guifg = "#657b83",
        guibg = "#002b36",
      },
      buffer_selected = {
        guifg = "#fdf6e3",
        gui = "bold",
      },
      fill = {
        guibg = "#073642",
      },
    },
  }
}
