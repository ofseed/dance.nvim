local installer = require "dance.installer"

local M = {}

local group = vim.api.nvim_create_augroup("dance", {})

function M.setup_installation_command()
  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    desc = "Setup installation command",
    pattern = "python",
    callback = function(args)
      local bufnr = args.buf

      vim.api.nvim_buf_create_user_command(bufnr, "DanceInstall", function()
        installer.install()
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

      if not installer.check() then
        vim.notify("No Python language server found. Try :DanceInstall", vim.log.levels.WARN)
        return
      end

      dance.start()
    end,
  })
end

return M
