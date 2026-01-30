-- Claude CLI integration with Telescope
return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")
      local pickers = require("telescope.pickers")
      local finders = require("telescope.finders")
      local conf = require("telescope.config").values

      local function claude_ask(prompt, context)
        local cmd = { "claude", "-p", prompt }
        if context and context ~= "" then
          cmd = { "claude", "-p", prompt .. "\n\nContext:\n" .. context }
        end

        local output = vim.fn.system(cmd)
        return output
      end

      local function claude_with_selection(prompt_prefix)
        local mode = vim.fn.mode()
        local text = ""

        if mode == "v" or mode == "V" then
          vim.cmd('normal! "vy')
          text = vim.fn.getreg("v")
        else
          local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
          text = table.concat(lines, "\n")
        end

        vim.ui.input({ prompt = "Claude prompt: ", default = prompt_prefix or "" }, function(input)
          if input then
            local result = claude_ask(input, text)
            -- 結果を新しいバッファに表示
            vim.cmd("vnew")
            vim.bo.buftype = "nofile"
            vim.bo.filetype = "markdown"
            local lines = vim.split(result, "\n")
            vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
          end
        end)
      end

      local claude_prompts = {
        { name = "Explain this code", prompt = "Explain this code in detail:" },
        { name = "Find bugs", prompt = "Find potential bugs in this code:" },
        { name = "Refactor", prompt = "Suggest refactoring improvements for this code:" },
        { name = "Add comments", prompt = "Add helpful comments to this code:" },
        { name = "Write tests", prompt = "Write unit tests for this code:" },
        { name = "Optimize", prompt = "Suggest performance optimizations for this code:" },
        { name = "Translate to English", prompt = "Translate this to English:" },
        { name = "Translate to Japanese", prompt = "Translate this to Japanese:" },
        { name = "Summarize", prompt = "Summarize this content:" },
        { name = "Custom prompt", prompt = "" },
      }

      -- Telescopeでプロンプトを選択
      local function claude_telescope()
        pickers
          .new({}, {
            prompt_title = "Claude Prompts",
            finder = finders.new_table({
              results = claude_prompts,
              entry_maker = function(entry)
                return {
                  value = entry,
                  display = entry.name,
                  ordinal = entry.name,
                }
              end,
            }),
            sorter = conf.generic_sorter({}),
            attach_mappings = function(prompt_bufnr, map)
              actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                claude_with_selection(selection.value.prompt)
              end)
              return true
            end,
          })
          :find()
      end

      -- ターミナルでClaude対話モードを開く
      local function claude_chat()
        vim.cmd("vsplit | terminal claude")
        vim.cmd("startinsert")
      end

      -- キーマップ登録
      vim.keymap.set("n", "<leader>cc", claude_telescope, { desc = "Claude: Select prompt" })
      vim.keymap.set("v", "<leader>cc", claude_telescope, { desc = "Claude: Select prompt with selection" })
      vim.keymap.set("n", "<leader>ci", claude_chat, { desc = "Claude: Interactive chat" })
      vim.keymap.set("n", "<leader>ca", function()
        claude_with_selection("")
      end, { desc = "Claude: Ask with buffer" })
      vim.keymap.set("v", "<leader>ca", function()
        claude_with_selection("")
      end, { desc = "Claude: Ask with selection" })
    end,
  },
}
