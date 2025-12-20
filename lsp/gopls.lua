-- Install with: go install golang.org/x/tools/gopls@latest
-- Make sure $GOPATH/bin is in the path
-- If not in path gopls and go will not work so language server will not work

---@type vim.lsp.Config
return {

  --Command to start the language server
    cmd = { 'gopls' },
    -- Files that indicate the project root
    root_markers = { 'go.mod', 'go.work', '.git' },
    -- File types that handle this server
    filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
    settings = {
        gopls = {
          -- Enable all analyses
          analyses = {
            unusedparams = true,
            shadow = true,
            unusedwrite = true,
            useany = true,
          },

          -- Enable static check
          staticcheck = true,

          -- Use gofumpt for formatting
          gofumpt = true,

          -- Autocomplete unimported packages
          completeUnimported = true,

          -- Show function signature help
          usePlaceholders = true,

          -- Auto-add function call parentheses on completion
          completeFunctionCalls = true,


          codelenses = {
            gc_details = true,
            generate = true,
            test = true,
            tidy = true,
          },

            hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
            },
        },
    },
}
