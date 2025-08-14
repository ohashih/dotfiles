local secrets = require("secrets")
return {
  {
    "ravitemer/mcphub.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("mcphub").setup({
        backend = "openai",
        backend_opts = {
          api_key = secrets.openai_api_key,
          model = "gpt-4o",
        },
      })
    end,
  },
  {
    "yetone/avante.nvim",
    build = "make",
    config = function()
      require("avante").setup({
        backend = "openai",
        model = "gpt-4o",
        api_key = require("secrets").openai_api_key,
      })
    end,
  },
}
