return {
  "L3MON4D3/LuaSnip",
  event = "InsertEnter",
  version = "v2.*",
  build = "make install_jsregexp",
  dependencies = {
    "rafamadriz/friendly-snippets",
  },
  -- keys = {
  --   {
  --     "<C-u>",
  --     function()
  --       require("luasnip").jump(1)
  --     end,
  --     { mode = { "i", "s" }, silent = true },
  --   },
  --   {
  --     "<C-i>",
  --     function()
  --       require("luasnip").jump(-1)
  --     end,
  --     { mode = { "i", "s" }, silent = true },
  --   },
  -- },
  -- config = function()
  --   require("luasnip.loaders.from_vscode").lazy_load()
  -- end,
}
