-- ================================================================================================
-- TITLE : LSP Configuration
-- ABOUT : Sets up Language Server Protocol for code intelligence (completions, go-to-definition,
--         diagnostics, etc.). Uses Neovim 0.11's built-in LSP support - no plugins required!
-- REQUIRES : Neovim 0.11+
-- ================================================================================================

-- ================================================================================================
-- ON_ATTACH
-- This function runs every time an LSP server attaches to a buffer.
-- Use it to set up keymaps that only make sense when LSP is active.
-- ================================================================================================
local function on_attach(client, bufnr)
  -- Helper function to create buffer-local keymaps
  local function map(keys, func, desc, mode)
    mode = mode or "n"
    vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
  end

  -- ==============================================================================================
  -- NAVIGATION KEYMAPS
  -- These help you jump around your code
  -- ==============================================================================================

  -- Go to where the symbol under cursor is defined
  if client:supports_method("textDocument/definition") then
    map("gd", vim.lsp.buf.definition, "Go to Definition")
  end

  -- Go to where the symbol is declared (subtly different from definition)
  if client:supports_method("textDocument/declaration") then
    map("gD", vim.lsp.buf.declaration, "Go to Declaration")
  end

  -- Find all references to the symbol under cursor
  if client:supports_method("textDocument/references") then
    map("gr", vim.lsp.buf.references, "Go to References")
  end

  -- Go to the type definition (e.g., for a variable, go to its type)
  if client:supports_method("textDocument/typeDefinition") then
    map("gy", vim.lsp.buf.type_definition, "Go to Type Definition")
  end

  -- Go to implementation (useful for interfaces/abstract classes)
  if client:supports_method("textDocument/implementation") then
    map("gi", vim.lsp.buf.implementation, "Go to Implementation")
  end

  -- ==============================================================================================
  -- INFORMATION KEYMAPS
  -- These show you information about code
  -- ==============================================================================================

  -- Show hover documentation (type info, docs) in a floating window
  map("K", vim.lsp.buf.hover, "Hover Documentation")

  -- Show function signature help while typing arguments
  if client:supports_method("textDocument/signatureHelp") then
    map("<C-k>", vim.lsp.buf.signature_help, "Signature Help", "i")
  end

  -- ==============================================================================================
  -- ACTION KEYMAPS
  -- These let you modify code
  -- ==============================================================================================

  -- Rename symbol under cursor across the project
  if client:supports_method("textDocument/rename") then
    map("<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
  end

  -- Show available code actions (quick fixes, refactors)
  if client:supports_method("textDocument/codeAction") then
    map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
  end

  -- Format the current buffer
  if client:supports_method("textDocument/formatting") then
    map("<leader>f", function()
      vim.lsp.buf.format({ async = true })
    end, "Format Buffer")
  end

  -- ==============================================================================================
  -- DIAGNOSTIC KEYMAPS
  -- These help you navigate errors and warnings
  -- ==============================================================================================

  -- Jump to previous diagnostic (error/warning)
  map("[d", function()
    vim.diagnostic.jump({ count = -1 })
  end, "Previous Diagnostic")

  -- Jump to next diagnostic
  map("]d", function()
    vim.diagnostic.jump({ count = 1 })
  end, "Next Diagnostic")

  -- Jump to previous error only (skip warnings)
  map("[e", function()
    vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })
  end, "Previous Error")

  -- Jump to next error only
  map("]e", function()
    vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })
  end, "Next Error")

  -- Show diagnostics in a floating window
  map("<leader>e", vim.diagnostic.open_float, "Show Diagnostic")

  -- Show all diagnostics in the quickfix list
  map("<leader>q", vim.diagnostic.setloclist, "Diagnostics to Quickfix")
end

-- ================================================================================================
-- DIAGNOSTIC CONFIGURATION
-- How errors, warnings, hints are displayed
-- ================================================================================================
vim.diagnostic.config({
  -- Virtual text: the inline text shown at the end of lines with issues
  virtual_text = {
    spacing = 2,
    prefix = "●", -- Simple dot prefix (no icons needed)
  },

  -- Floating window configuration (when you press <leader>e)
  float = {
    border = "rounded",
    source = true, -- Show which LSP/linter produced the diagnostic
  },

  -- Underline problematic code
  underline = true,

  -- Update diagnostics even in insert mode (set to false if distracting)
  update_in_insert = false,

  -- Sort diagnostics by severity (errors first)
  severity_sort = true,

  -- Signs in the gutter (left margin)
  -- Using simple text characters instead of icons
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "E",
      [vim.diagnostic.severity.WARN] = "W",
      [vim.diagnostic.severity.INFO] = "I",
      [vim.diagnostic.severity.HINT] = "H",
    },
  },
})

-- ================================================================================================
-- HOVER AND SIGNATURE HELP WINDOW SIZE
-- Limit the size of floating documentation windows
-- ================================================================================================
local hover = vim.lsp.buf.hover
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.buf.hover = function()
  return hover({
    max_height = math.floor(vim.o.lines * 0.5),
    max_width = math.floor(vim.o.columns * 0.4),
  })
end

local signature_help = vim.lsp.buf.signature_help
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.buf.signature_help = function()
  return signature_help({
    max_height = math.floor(vim.o.lines * 0.5),
    max_width = math.floor(vim.o.columns * 0.4),
  })
end

-- ================================================================================================
-- LSP ATTACH AUTOCMD
-- Runs on_attach whenever an LSP server connects to a buffer
-- ================================================================================================
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
  desc = "Configure LSP keymaps and settings",
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end
    on_attach(client, args.buf)
  end,
})

-- ================================================================================================
-- AUTO-ENABLE LSP SERVERS
-- Discovers all server configs in the lsp/ directory and enables them.
-- Each file in lsp/ should return a vim.lsp.Config table.
-- ================================================================================================
vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("UserLspStart", { clear = true }),
  once = true, -- Only run once, not for every buffer
  desc = "Start LSP servers",
  callback = function()
    -- Optional: Extend capabilities with blink.cmp if available
    -- This enables better completion support
    local ok, blink = pcall(require, "blink.cmp")
    if ok then
      vim.lsp.config("*", {
        capabilities = blink.get_lsp_capabilities(nil, true),
      })
    end

    -- Find all LSP config files in the lsp/ directory
    -- Each file should be named after the server (e.g., lua_ls.lua, tsgo.lua)
    local config_files = vim.api.nvim_get_runtime_file("lsp/*.lua", true)

    -- Extract server names from file paths
    local servers = vim.iter(config_files)
      :map(function(file)
        return vim.fn.fnamemodify(file, ":t:r") -- Get filename without extension
      end)
      :totable()

    -- Enable all discovered servers
    if #servers > 0 then
      vim.lsp.enable(servers)
    end
  end,
})

return {}
