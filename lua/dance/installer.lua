local utils = require "dance.utils"

local M = {}

--- Install the language server
---@param prevent_start boolean? whether to start after the installation is completed
function M.install(prevent_start)
  vim.notify "Installing Pylance..."
  utils
    .system({
      "wget",
      "https://github.com/mochaaP/pylance-standalone/archive/dist.zip",
      "--directory-prefix",
      M.opts.server.path,
    })
    :next(function()
      vim.notify "Extracting..."
      return utils.system {
        "unzip",
        M.opts.server.path .. "/dist.zip",
        "-d",
        M.opts.server.path,
      }
    end)
    :next(function()
      return utils.system {
        "mv",
        M.opts.server.path .. "/pylance-standalone-dist",
        M.opts.server.path .. "/pylance",
      }
    end)
    :next(function()
      return utils.system {
        "rm",
        M.opts.server.path .. "/dist.zip",
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
