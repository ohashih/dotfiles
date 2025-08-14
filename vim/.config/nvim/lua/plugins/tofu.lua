return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        tf = { "tfmt" },
        terraform = { "tfmt" },
        hcl = { "tfmt" },
      },
      formatters = {
        tfmt = {
          command = "tofu",
          args = { "fmt", "-" },
          stdin = true,
        },
      },
    },
  },
  -- {
  --   "nathom/filetype.nvim",
  --   enable = false,
  --   config = function()
  --     require("filetype").setup({
  --       overrides = {
  --         extensions = {
  --           tf = "terraform",
  --           tofu = "terraform",
  --           tfvars = "terraform",
  --           tfstate = "json",
  --         },
  --       },
  --     })
  --   end,
  -- },
}
