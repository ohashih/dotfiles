return {
  "numToStr/Comment.nvim",
  event = "UIEnter",
  dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
  opts = {
    enable_autocmd = false,
    toggler = {
      line = "gcc",
      block = "gbc",
    },
    opleader = {
      line = "gc",
      block = "gb",
    },
    extra = {
      above = "gcO",
      below = "gco",
      eol = "gcA",
    },
    pre_hook = function()
      require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
    end,
  },
}
