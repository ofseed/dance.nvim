local M = {}

---@class DanceServerConfig
---@field name string
---@field path string
---@field runtime "node" | "bun"
---@field entry string | fun(server_path: string): string

---@class DanceConfig
---@field auto_start boolean
---@field server DanceServerConfig
---@field capabilities lsp.ClientCapabilities
---@field settings table

function M.get_defaults()
  ---@type DanceConfig
  local defaults = {
    auto_start = true,
    server = {
      name = "pylance",
      ---@diagnostic disable-next-line: param-type-mismatch
      path = vim.fs.joinpath(vim.fn.stdpath "data", "dance"),
      runtime = "node",
      entry = function(server_path)
        return vim.fs.joinpath(server_path, "pylance", "server.bundle.js")
      end,
    },
    capabilities = vim.lsp.protocol.make_client_capabilities(),
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = "openFilesOnly",
        },
      },
    },
  }
  return defaults
end

return M
