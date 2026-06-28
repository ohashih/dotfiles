return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = function()
      return {
        options = {
          mode = "buffers",
          separator_style = "slant",
          always_show_bufferline = false,
          show_buffer_close_icons = false,
          show_close_icon = false,
          color_icons = true,
          diagnostics = "nvim_lsp",
          diagnostics_indicator = function(count, level)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
          end,
        },
        -- 配色は catppuccin integration に委譲 (ハードコード solarized を撤去)
        highlights = require("catppuccin.special.bufferline").get_theme(),
      }
    end,
  },
}
