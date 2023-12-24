local M = {}

local group = vim.api.nvim_create_augroup("dance", {})

function M.setup_auto_start()
  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    desc = "Auto start language server",
    pattern = "python",
    callback = function()
      local dance = require "dance"

      ---@diagnostic disable-next-line: param-type-mismatch
      if not vim.uv.fs_stat(dance.opts.server.entry) then
        vim.notify("No Python language server found", vim.log.levels.WARN)
        return
      end

      dance.start()
    end,
  })
end

return M
