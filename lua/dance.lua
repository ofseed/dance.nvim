local config = require "dance.config"
local utils = require "dance.utils"

local M = {}

---@type DanceConfig
M.opts = {}

function M.install()
  utils
    .system({
      "wget",
      "https://github.com/mochaaP/pylance-standalone/archive/dist.zip",
      "--directory-prefix",
      M.opts.path,
    })
    :next(function()
      return utils.system {
        "unzip",
        M.opts.path .. "/dist.zip",
        "-d",
        M.opts.path,
      }
    end)
    :next(function()
      return utils.system {
        "mv",
        M.opts.path .. "/pylance-standalone-dist",
        M.opts.path .. "/pylance",
      }
    end)
    :next(function()
      return utils.system {
        "rm",
        M.opts.path .. "/dist.zip",
      }
    end)
    :next(function()
      vim.notify "Pylance installed"
    end)
end

function M.start(client_config)
  return vim.lsp.start({
    name = "pylance",
    cmd = {
      "node",
      M.opts.path .. "/pylance/server.bundle.js",
      "--stdio",
    },
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = "openFilesOnly",
        },
      },
    },
  }, {})
end

---@param opts DanceConfig | nil
function M.setup(opts)
  opts = opts or {}
  M.opts = config.get_defaults()
  M.opts = vim.tbl_deep_extend("force", M.opts, opts)
end

return M
