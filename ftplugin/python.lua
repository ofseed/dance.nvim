local dance = require "dance"

---@diagnostic disable-next-line: param-type-mismatch
if not vim.uv.fs_stat(dance.opts.server.entry) then
  vim.notify("No Python language server found", vim.log.levels.WARN)
  return
end

dance.start()
