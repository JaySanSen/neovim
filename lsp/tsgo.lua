
--- Install with npm i -g @typescript/native-preview
---
---
---@type vim.lsp.Config

return {
  -- Command to start the language server
  cmd = { "tsgo", "--lsp", "--stdio" },

  -- File types this server handles
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },

  -- Files that indicate the project root (helps LSP find you tsconfig.json, etc.)
  root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },

}
