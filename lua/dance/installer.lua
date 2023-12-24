local utils = require "dance.utils"

local M = {}

--- Install the language server
---@param prevent_start boolean? whether to start after the installation is completed
function M.install(prevent_start)
  local dance = require "dance"

  vim.notify "Installing Pylance..."
  utils
    .system({
      "wget",
      "https://github.com/mochaaP/pylance-standalone/archive/dist.zip",
      "--directory-prefix",
      dance.opts.server.path,
    })
    :next(function()
      vim.notify "Extracting..."
      return utils.system {
        "unzip",
        dance.opts.server.path .. "/dist.zip",
        "-d",
        dance.opts.server.path,
      }
    end)
    :next(function()
      return utils.system {
        "rm",
        dance.opts.server.path .. "/dist.zip",
      }
    end)
    :next(function()
      vim.notify "Pylance installed"
      if not prevent_start then
        M.start()
      end
    end)
end

return M
