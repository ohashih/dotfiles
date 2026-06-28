-- 補完エンジン: blink.cmp (nvim-cmp から移行)
-- Rust製の fuzzy matcher を備えた高速な補完エンジン。
-- kind icon / signature / cmdline 補完を内蔵し、cmp-* 系ソースや lspkind を不要化する。
return {
  {
    "saghen/blink.cmp",
    version = "1.*",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "rafamadriz/friendly-snippets",
      {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
      },
      -- Copilot 補完を blink のソースとして取り込む
      "fang2hou/blink-copilot",
      "zbirenbaum/copilot.lua",
    },
    opts = {
      snippets = { preset = "luasnip" },

      -- 旧 nvim-cmp のキーマップを踏襲
      keymap = {
        preset = "none",
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<C-n>"] = { "show", "select_next", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback" },
        ["<C-e>"] = { "hide", "fallback" },
        ["<C-f>"] = { "accept", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },
      },

      appearance = {
        nerd_font_variant = "mono",
      },

      completion = {
        -- VSCode 同様、入力に応じて自動でメニューを表示
        menu = {
          border = "rounded",
          winblend = 0,
          draw = {
            treesitter = { "lsp" },
            columns = {
              { "kind_icon" },
              { "label", "label_description", gap = 1 },
              { "source_name" },
            },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
          window = { border = "rounded" },
        },
        list = {
          selection = { preselect = false, auto_insert = true },
        },
        ghost_text = { enabled = false },
      },

      signature = {
        enabled = true,
        window = { border = "rounded" },
      },

      sources = {
        default = { "copilot", "lsp", "path", "snippets", "buffer" },
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-copilot",
            score_offset = 100,
            async = true,
          },
        },
      },

      -- コマンドライン補完
      cmdline = {
        keymap = {
          preset = "cmdline",
          ["<C-f>"] = { "accept", "fallback" },
        },
        completion = {
          menu = { auto_show = true },
          list = { selection = { preselect = false } },
        },
      },

      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
  },
}
