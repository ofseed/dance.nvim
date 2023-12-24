local config = require "dance.config"
local utils = require "dance.utils"

local M = {}

function M.install()
  utils
    .system({
      "wget",
      "https://github.com/mochaaP/pylance-standalone/archive/dist.zip",
      "--directory-prefix",
      config.path,
    })
    :next(function()
      return utils.system {
        "unzip",
        config.path .. "/dist.zip",
        "-d",
        config.path,
      }
    end)
    :next(function()
      return utils.system {
        "mv",
        config.path .. "/pylance-standalone-dist",
        config.path .. "/pylance",
      }
    end)
    :next(function()
      return utils.system {
        "rm",
        config.path .. "/dist.zip",
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
      config.path .. "/pylance/server.bundle.js",
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

function M.setup(opts) end

return M
