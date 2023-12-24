local M = {}

function M.organize_imports()
  local params = {
    command = "pyright.organizeimports",
    arguments = { vim.uri_from_bufnr(0) },
  }

  vim.lsp.buf.execute_command(params)
end

return M
