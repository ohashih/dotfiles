return {
  {
    "davidmh/mdx.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    opts = {
      ensure_installed = {
        "lua",
        "vim",
        "vimdoc",
        "query",
        "bash",
        "python",
        "javascript",
        "typescript",
        "go",
        "rust",
      },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function(_, opts)
      -- 新しいAPI（v1.0+）を試し、失敗したら旧APIにフォールバック
      local ok, configs = pcall(require, "nvim-treesitter.configs")
      if ok then
        configs.setup(opts)
      else
        -- v1.0+: 直接vim.treesitterを使用
        require("nvim-treesitter").setup(opts)
      end
      vim.filetype.add({
        extension = {
          tofu = "terraform",
          mdx = "mdx",
        },
      })
    end,
  },
  {
    "shellRaining/hlchunk.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("hlchunk").setup({
        chunk = {
          enable = true,
          use_treesitter = true,
          notify = false,
          textobject = "",
          chars = {
            horizontal_line = "─",
            vertical_line = "│",
            left_top = "╭",
            left_bottom = "╰",
            right_arrow = ">",
          },
        },
        line_num = {
          enable = false,
        },
        indent = {
          enable = true,
          chars = { "│" },
        },
      })
    end,
  },
  --trailing space
  {
    "bronson/vim-trailing-whitespace",
  },
  -- scroll view
  {
    "dstein64/nvim-scrollview",
    lazy = true,
  },
  -- hightlight
  {
    "dominikduda/vim_current_word",
    lazy = false,
    config = function()
      vim.g["current_word#highlight_delay"] = 100
      vim.g["current_word#highlight_twins"] = 1
      vim.g["current_word#enabled"] = 1
      vim.cmd([[highlight CurrentWord guibg=#45475a guifg=NONE ctermbg=238]])
      vim.cmd([[highlight CurrentWordTwins guibg=#585b70 guifg=NONE ctermbg=240]])
    end,
  },

  --render-markdown
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons", "echasnovski/mini.icons" },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },
}
