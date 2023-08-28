local util = require("formatter.util")
local function markdownlint()
  return {
    exe = "markdownlint",
    stdin = true,
    args = {
      "--fix",
      util.escape_path(util.get_current_buffer_file_path()),
    },
  }
end

require("formatter").setup({
  logging = true,
  log_level = vim.log.levels.WARN,
  filetype = {
    lua = {
      require("formatter.filetypes.lua").stylua,

      function()
        if util.get_current_buffer_file_name() == "special.lua" then
          return nil
        end

        return {
          exe = "stylua",
          args = {
            "--search-parent-directories",
            "--stdin-filepath",
            util.escape_path(util.get_current_buffer_file_path()),
            "--",
            "-",
          },
          stdin = true,
        }
      end,
    },
    markdown = {
      require("formatter.filetypes.markdown").prettierd,
    },
    ["*"] = {
      require("formatter.filetypes.any").remove_trailing_whitespace,
    },
  },
})
-- file on save
vim.api.nvim_create_augroup("fileOnSave", {})
vim.api.nvim_create_autocmd("BufWritePost", {
  group = "fileOnSave",
  command = "FormatWrite",
})
