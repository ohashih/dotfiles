-- AI 連携を Claude 中心に再編
--   * claudecode.nvim : Claude Code CLI (サブスク) とエディタを直結 (<leader>a*)
--   * codecompanion.nvim : 構造化チャット / インライン / 日本語プロンプト集 (<leader>c*)
return {
  -- Claude Code CLI 連携 (API キー不要。Claude Code サブスクを利用)
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    cmd = {
      "ClaudeCode",
      "ClaudeCodeFocus",
      "ClaudeCodeSend",
      "ClaudeCodeAdd",
      "ClaudeCodeDiffAccept",
      "ClaudeCodeDiffDeny",
    },
    keys = {
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Claude Code: Toggle" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Claude Code: Focus" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Claude Code: Resume" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Claude Code: Continue" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Claude Code: Add current buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Claude Code: Send selection" },
      { "<leader>ay", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Claude Code: Accept diff" },
      { "<leader>an", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Claude Code: Deny diff" },
    },
    opts = {},
  },

  -- 構造化された AI チャット/インライン。既定は Anthropic (最新 Claude)。
  -- ANTHROPIC_API_KEY が必要。サブスク運用のみなら上の claudecode を主に使う。
  {
    "olimorris/codecompanion.nvim",
    cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      { "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "CodeCompanion: Chat" },
      { "<leader>cp", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "CodeCompanion: Actions" },
      { "<leader>ci", ":CodeCompanion<cr>", mode = { "n", "v" }, desc = "CodeCompanion: Inline" },
    },
    opts = {
      adapters = {
        anthropic = function()
          return require("codecompanion.adapters").extend("anthropic", {
            schema = { model = { default = "claude-sonnet-4-6" } },
          })
        end,
      },
      strategies = {
        chat = { adapter = "anthropic" },
        inline = { adapter = "anthropic" },
      },
      -- CopilotChat から移植した日本語プロンプト集
      prompt_library = {
        ["Explain (JP)"] = {
          strategy = "chat",
          description = "コードを日本語で説明",
          prompts = { { role = "user", content = "選択したコードを日本語で詳しく説明してください。" } },
        },
        ["Review (JP)"] = {
          strategy = "chat",
          description = "コードを日本語でレビュー",
          prompts = { { role = "user", content = "選択したコードを日本語でレビューし、改善点を挙げてください。" } },
        },
        ["Fix (JP)"] = {
          strategy = "chat",
          description = "バグ修正を日本語で",
          prompts = { { role = "user", content = "このコードのバグを修正し、修正内容を日本語で説明してください。" } },
        },
        ["Optimize (JP)"] = {
          strategy = "chat",
          description = "最適化を日本語で",
          prompts = { { role = "user", content = "選択したコードをパフォーマンスと可読性の観点で最適化し、日本語で説明してください。" } },
        },
        ["Tests (JP)"] = {
          strategy = "chat",
          description = "テスト生成を日本語で",
          prompts = { { role = "user", content = "選択したコードの詳細なユニットテストを書き、説明を日本語でお願いします。" } },
        },
        ["Commit (JP)"] = {
          strategy = "chat",
          description = "コミットメッセージを日本語で",
          prompts = {
            {
              role = "user",
              content = function()
                return "次の差分に対するコミットメッセージを日本語で記述してください。\n\n```diff\n"
                  .. vim.fn.system("git diff --staged")
                  .. "\n```"
              end,
            },
          },
        },
      },
    },
  },
}
