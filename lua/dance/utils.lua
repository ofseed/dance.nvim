local deferred = require "dance.deferred"

local M = {}

--- Deferred wrapper for `vim.system`
---@param cmd string[]
---@param opts SystemOpts | nil
M.system = function(cmd, opts)
  local d = deferred:new()
  ---@param out vim.SystemCompleted
  vim.system(cmd, opts, function(out)
    if out.code == 0 then
      d:resolve(out)
    else
      d:reject(out)
    end
  end)
  return d
end

return M
