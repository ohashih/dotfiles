return {
  --Color
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
  },
  {
    "davidmh/mdx.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")
      configs.setup({
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
      })
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
    event = "TextYankPost", -- ヤンクイベントが発生したときに読み込む
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
  -- {
  --   "anuvyklack/pretty-fold.nvim",
  --   lazy = true,                             -- 必要に応じて遅延読み込み
  --   event = { "BufReadPost", "BufNewFile" }, -- ファイル読み込み時に読み込む
  --   config = function()
  --     require("pretty-fold").setup({
  --       sections = {
  --         left = {
  --           "content", -- フォールド内のテキストを表示
  --         },
  --         right = {
  --           " ",
  --           "number_of_folded_lines",
  --           " lines ", -- 折り畳まれた行数を表示
  --         },
  --       },
  --       fill_char = "·",            -- フォールドラインを埋める文字
  --       remove_fold_markers = true, -- デフォルトのフォールドマーカーを非表示
  --       -- カスタマイズ可能なキーマッピング
  --       key_mappings = {
  --         toggle_fold = "za",     -- フォールドの開閉
  --         close_all_folds = "zM", -- 全てのフォールドを閉じる
  --         open_all_folds = "zR",  -- 全てのフォールドを開く
  --       },
  --     })
  --   end,
  -- },
  -- --fold-preview
  -- {
  --   "anuvyklack/fold-preview.nvim",
  --   dependencies = { "anuvyklack/keymap-amend.nvim" }, -- 必須依存プラグイン
  --   lazy = true,                                       -- 遅延読み込みを有効化
  --   event = { "BufReadPost", "BufNewFile" },           -- ファイル読み込み時に読み込む
  --   config = function()
  --     require("fold-preview").setup({
  --       border = "rounded",                                   -- プレビューウィンドウのボーダータイプ ("none", "single", "double", "rounded", "shadow")
  --       auto = 500,                                           -- 自動プレビューまでの遅延時間（ms）
  --       preview_command = "bat --style=plain --paging=never", -- プレビュー内容を整形するコマンド
  --       default_keymaps = true,                               -- デフォルトのキーマッピングを有効にする
  --     })
  --   end,
  -- },
  --render-markdown
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },
  -- --obsidian
  -- {
  --   "oflisback/obsidian-bridge.nvim",
  --   opts = { scroll_sync = true },
  -- },

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
