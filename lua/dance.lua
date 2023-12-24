local autocmds = require "dance.autocmds"
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
      M.opts.server.path,
    })
    :next(function()
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
    end)
end

function M.start(client_config)
  return vim.lsp.start({
    name = "pylance",
    cmd = {
      M.opts.server.runtime,
      M.opts.server.entry,
      "--stdio",
    },
    settings = M.opts.settings,
  }, {})
end

---@param opts DanceConfig | nil
function M.setup(opts)
  opts = opts or {}

  M.opts = config.get_defaults()
  M.opts = vim.tbl_deep_extend("force", M.opts, opts)
  if type(M.opts.server.entry) == "function" then
    M.opts.server.entry = M.opts.server.entry(M.opts.server.path)
  end

  if M.opts.auto_start then
    autocmds.setup_auto_start()
  end
end

return M
