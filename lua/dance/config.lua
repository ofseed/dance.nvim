local M = {}

---@class DanceServerConfig
---@field path string
---@field runtime "node" | "bun"
---@field entry string | fun(server_path: string): string

---@class DanceConfig
---@field server DanceServerConfig

function M.get_defaults()
  ---@type DanceConfig
  local defaults = {
    server = {
      ---@diagnostic disable-next-line: param-type-mismatch
      path = vim.fs.joinpath(vim.fn.stdpath "data", "dance"),
      runtime = "node",
      entry = function(server_path)
        return vim.fs.joinpath(server_path, "pylance", "server.bundle.js")
      end,
    },
  }
  return defaults
end

return M
