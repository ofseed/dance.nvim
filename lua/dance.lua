local config = require "dance.config"

local M = {}

function M.install()
  vim.system({
    "wget",
    "https://github.com/mochaaP/pylance-standalone/archive/dist.zip",
    "--directory-prefix",
    config.path,
  }, {}, function()
    vim.system({
      "unzip",
      config.path .. "/dist.zip",
      "-d",
      config.path,
    }, {}, function()
      vim.system({
        "mv",
        config.path .. "/pylance-standalone-dist",
        config.path .. "/pylance",
      }, {}, function()
        vim.system({
          "rm",
          config.path .. "/dist.zip",
        }, {}, function()
          vim.print "Pylance installed"
        end)
      end)
    end)
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
