return {
  --Color
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
  },
  -- hightlight
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "terraform", "hcl" })
      end
      vim.filetype.add({
        extension = { tofu = "terraform" },
      })
    end,
    config = function()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = "all",
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
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
          notify = true,
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
  -- yank highlight
  {
    "machakann/vim-highlightedyank",
    event = "TextYankPost",
    config = function()
      vim.g.highlightedyank_highlight_duration = 300 -- ハイライトが表示される時間（ミリ秒）
      vim.api.nvim_exec(
        [[
        augroup highlight_yank
          autocmd!
          autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=300}
        augroup END
      ]],
        false
      )
    end,
  },
  -- scroll smooth
  {
    "karb94/neoscroll.nvim",
    lazy = true,
    config = function()
      require("neoscroll").setup()
    end,
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
  --fold
  {
    "anuvyklack/pretty-fold.nvim",
    lazy = true,
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("pretty-fold").setup({
        sections = {
          left = {
            "content",
          },
          right = {
            " ",
            "number_of_folded_lines",
            " lines ",
          },
        },
        fill_char = "·",
        remove_fold_markers = true,
        key_mappings = {
          toggle_fold = "za",
          close_all_folds = "zM",
          open_all_folds = "zR",
        },
      })
    end,
  },
  --fold-preview
  {
    "anuvyklack/fold-preview.nvim",
    dependencies = { "anuvyklack/keymap-amend.nvim" },
    lazy = true,
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("fold-preview").setup({
        border = "rounded",
        auto = 500,
        preview_command = "bat --style=plain --paging=never",
        default_keymaps = true,
      })
    end,
  },
  --render-markdown
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' },
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },
  --obsidian
  {
    "oflisback/obsidian-bridge.nvim",
    opts = { scroll_sync = true }
  },

  -- auto-pairs
  --[[ {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    lazy = true,
    config = function()
      require("nvim-autopairs").setup()
    end,
  }, ]]
}
