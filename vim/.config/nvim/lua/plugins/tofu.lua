return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        tf = { "tofu_fmt" },
        terraform = { "tofu_fmt" },
        hcl = { "tofu_fmt" },
      },
      formatters = {
        tofu_fmt = {
          command = "tofu",
          args = { "fmt", "-" },
          stdin = true,
        },
      },
    },
  },
}
