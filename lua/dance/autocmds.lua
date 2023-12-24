local M = {}

local group = vim.api.nvim_create_augroup("dance", {})

function M.setup_installation_command()
  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    desc = "Setup installation command",
    pattern = "python",
    callback = function(args)
      local dance = require "dance"
      local bufnr = args.buf

      vim.api.nvim_buf_create_user_command(bufnr, "DanceInstall", function()
        dance.install()
      end, {})
    end,
  })
end

function M.setup_auto_start()
  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    desc = "Auto start language server",
    pattern = "python",
    callback = function()
      local dance = require "dance"

      ---@diagnostic disable-next-line: param-type-mismatch
      if not vim.uv.fs_stat(dance.opts.server.entry) then
        vim.notify("No Python language server found. Try :DanceInstall", vim.log.levels.WARN)
        return
      end

      dance.start()
    end,
  })
end

return M
