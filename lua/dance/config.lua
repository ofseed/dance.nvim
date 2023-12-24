local M = {}

function M.get_defaults()
  ---@class DanceConfig
  local defaults = {
    ---@diagnostic disable-next-line: param-type-mismatch
    path = vim.fs.joinpath(vim.fn.stdpath "data", "dance"),
  }
  return defaults
end

return M
