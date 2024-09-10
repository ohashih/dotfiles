local status, packer = pcall(require, "packer")
if not status then
  print("Packer is not installed")
  return
end

vim.cmd([[packadd packer.nvim]])

packer.startup(function(use)
  use("wbthomason/packer.nvim")

  -- emphasize & delete space
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("configs.treesitter")
    end,
  })

  use({
    "bronson/vim-trailing-whitespace",
  })

  -- tab & buffer & status
  use({
    "kdheepak/tabline.nvim",
  })
  use({
    "akinsho/bufferline.nvim",
    tag = "*",
    requires = "nvim-tree/nvim-web-devicons",
  })
  use({
    "nvim-lualine/lualine.nvim",
    requires = { "nvim-tree/nvim-web-devicons", opt = true },
  })
  -- color
  use({
    "folke/tokyonight.nvim",
  })

  use({
    "gko/vim-coloresque",
  })

  -- indent
  use({
    "lukas-reineke/indent-blankline.nvim",
  })

  -- commentout
  use({
    "tomtom/tcomment_vim",
  })

  -- yank highlight
  use({
    "machakann/vim-highlightedyank",
    config = function()
      require("configs.highlight-yank")
    end,
  })

  -- resize window
  use({
    "simeji/winresizer",
  })

  -- atuotag notwork
  use({ "windwp/nvim-ts-autotag" })

  -- git
  use({
    "sindrets/diffview.nvim",
    config = function()
      require("configs.git")
    end,
  })

  use({
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  })

  use({
    "f-person/git-blame.nvim",
    config = function()
      require("gitblame").setup()
    end,
  })

  -- notice
  use({
    "folke/noice.nvim",
    config = function()
      require("configs.noice")
    end,
    requires = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  })

  -- filetree
  use({
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      {
        "s1n7ax/nvim-window-picker",
        tag = "v1.*",
        config = function()
          require("window-picker").setup({
            autoselect_one = true,
            include_current = false,
            filter_rules = {
              bo = {
                filetype = { "neo-tree", "neo-tree-popup", "notify" },
                buftype = { "terminal", "quickfix" },
              },
            },
            other_win_hl_color = "#e35e4f",
          })
        end,
      },
    },
    config = function()
      require("configs.neo-tree")
    end,
    vim.cmd([[nnoremap \ :Neotree reveal<cr>]]),
  })

  -- telescope
  use({
    "nvim-telescope/telescope-file-browser.nvim",
    requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  })

  -- lsp
  use({
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  })

  use("hrsh7th/nvim-cmp")
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-cmdline")
  use("hrsh7th/vim-vsnip")
  use("hrsh7th/cmp-vsnip")
  use("onsails/lspkind.nvim")
  use({
    "glepnir/lspsaga.nvim",
    branch = "main",
  })

  use({
    "mhartington/formatter.nvim",
    config = function()
      require("configs.formatter")
    end,
  })

  -- vim help
  use({
    "vim-jp/vimdoc-ja",
    lazy = true,
    key = {
      {
        "h",
        mode = "c",
      },
    },
  })
end)
