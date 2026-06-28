-- デバッグ (DAP): VSCode 級のステップ実行・ブレークポイント・変数インスペクト
return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
      "jay-babu/mason-nvim-dap.nvim",
      "williamboman/mason.nvim",
    },
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "DAP: Toggle breakpoint" },
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Condition: ")) end, desc = "DAP: Conditional breakpoint" },
      { "<F5>", function() require("dap").continue() end, desc = "DAP: Continue / Start" },
      { "<F10>", function() require("dap").step_over() end, desc = "DAP: Step over" },
      { "<F11>", function() require("dap").step_into() end, desc = "DAP: Step into" },
      { "<F12>", function() require("dap").step_out() end, desc = "DAP: Step out" },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "DAP: Toggle REPL" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "DAP: Run last" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "DAP: Terminate" },
      { "<leader>du", function() require("dapui").toggle() end, desc = "DAP: Toggle UI" },
      { "<leader>de", function() require("dapui").eval() end, mode = { "n", "v" }, desc = "DAP: Eval" },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      require("mason-nvim-dap").setup({
        ensure_installed = { "js-debug-adapter", "debugpy", "delve", "codelldb" },
        automatic_installation = true,
        handlers = {}, -- デフォルトハンドラで各アダプタを自動セットアップ
      })

      dapui.setup()
      require("nvim-dap-virtual-text").setup({})

      -- UI を自動開閉
      dap.listeners.before.attach.dapui_config = function() dapui.open() end
      dap.listeners.before.launch.dapui_config = function() dapui.open() end
      dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
      dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

      -- ブレークポイントのアイコン
      vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticError", linehl = "", numhl = "" })
      vim.fn.sign_define("DapStopped", { text = "", texthl = "DiagnosticWarn", linehl = "Visual", numhl = "" })
    end,
  },
}
