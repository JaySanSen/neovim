-- ================================================================================================
-- STATUSLINE
-- A custom statusline showing: mode | git | lsp progress | filetype | position
-- ================================================================================================

local icons = require("icons")

local M = {}

-- Don't show the command that produced the quickfix list
vim.g.qf_disable_statusline = 1

-- Show the mode in our custom component instead
vim.o.showmode = false

-- =============================================================================
-- HIGHLIGHT HELPER
-- Creates highlight groups for icons by combining their fg with statusline bg
-- =============================================================================
---@type table<string, boolean>
local statusline_hls = {}

---@param hl string
---@return string
function M.get_or_create_hl(hl)
  local hl_name = "Statusline" .. hl

  if not statusline_hls[hl] then
    local bg_hl = vim.api.nvim_get_hl(0, { name = "StatusLine" })
    local fg_hl = vim.api.nvim_get_hl(0, { name = hl })

    if bg_hl.bg and fg_hl.fg then
      vim.api.nvim_set_hl(0, hl_name, {
        bg = ("#%06x"):format(bg_hl.bg),
        fg = ("#%06x"):format(fg_hl.fg),
      })
    end
    statusline_hls[hl] = true
  end

  return hl_name
end

-- =============================================================================
-- MODE COMPONENT
-- Shows current vim mode with color coding
-- =============================================================================
function M.mode_component()
  local mode_to_str = {
    ["n"] = "NORMAL",
    ["no"] = "OP-PENDING",
    ["nov"] = "OP-PENDING",
    ["noV"] = "OP-PENDING",
    ["no\22"] = "OP-PENDING",
    ["niI"] = "NORMAL",
    ["niR"] = "NORMAL",
    ["niV"] = "NORMAL",
    ["nt"] = "NORMAL",
    ["ntT"] = "NORMAL",
    ["v"] = "VISUAL",
    ["vs"] = "VISUAL",
    ["V"] = "VISUAL",
    ["Vs"] = "VISUAL",
    ["\22"] = "VISUAL",
    ["\22s"] = "VISUAL",
    ["s"] = "SELECT",
    ["S"] = "SELECT",
    ["\19"] = "SELECT",
    ["i"] = "INSERT",
    ["ic"] = "INSERT",
    ["ix"] = "INSERT",
    ["R"] = "REPLACE",
    ["Rc"] = "REPLACE",
    ["Rx"] = "REPLACE",
    ["Rv"] = "VIRT REPLACE",
    ["Rvc"] = "VIRT REPLACE",
    ["Rvx"] = "VIRT REPLACE",
    ["c"] = "COMMAND",
    ["cv"] = "VIM EX",
    ["ce"] = "EX",
    ["r"] = "PROMPT",
    ["rm"] = "MORE",
    ["r?"] = "CONFIRM",
    ["!"] = "SHELL",
    ["t"] = "TERMINAL",
  }

  local mode = mode_to_str[vim.api.nvim_get_mode().mode] or "UNKNOWN"

  -- Choose highlight based on mode
  local hl = "Other"
  if mode:find("NORMAL") then
    hl = "Normal"
  elseif mode:find("PENDING") then
    hl = "Pending"
  elseif mode:find("VISUAL") then
    hl = "Visual"
  elseif mode:find("INSERT") or mode:find("SELECT") then
    hl = "Insert"
  elseif mode:find("COMMAND") or mode:find("TERMINAL") or mode:find("EX") then
    hl = "Command"
  end

  return string.format("%%#StatuslineMode%s# %s ", hl, mode)
end

-- =============================================================================
-- GIT COMPONENT
-- Shows current branch (requires gitsigns)
-- =============================================================================
-- function M.git_component()
--   local head = vim.b.gitsigns_head
--   if not head or head == "" then
--     return ""
--   end
--
--   return string.format(" %s %s", icons.misc.git, head)
-- end

-- =============================================================================
-- LSP PROGRESS COMPONENT
-- Shows LSP loading status
-- =============================================================================
---@type table<string, string?>
local progress_status = {
  client = nil,
  kind = nil,
  title = nil,
}

vim.api.nvim_create_autocmd("LspProgress", {
  group = vim.api.nvim_create_augroup("user/statusline_lsp_progress", { clear = true }),
  desc = "Update LSP progress in statusline",
  pattern = { "begin", "end" },
  callback = function(args)
    if not args.data then
      return
    end

    local client = vim.lsp.get_client_by_id(args.data.client_id)
    progress_status = {
      client = client and client.name or nil,
      kind = args.data.params.value.kind,
      title = args.data.params.value.title,
    }

    if progress_status.kind == "end" then
      progress_status.title = nil
      vim.defer_fn(function()
        vim.cmd.redrawstatus()
      end, 3000)
    else
      vim.cmd.redrawstatus()
    end
  end,
})

function M.lsp_progress_component()
  if not progress_status.client or not progress_status.title then
    return ""
  end

  -- Don't show while typing
  if vim.startswith(vim.api.nvim_get_mode().mode, "i") then
    return ""
  end

  return string.format("%%#StatuslineSpinner#󱥸 %%#StatuslineTitle#%s %%#StatuslineItalic#%s...",
    progress_status.client,
    progress_status.title
  )
end

-- =============================================================================
-- DIAGNOSTICS COMPONENT
-- Shows error/warning counts
-- =============================================================================
function M.diagnostics_component()
  local counts = vim.diagnostic.count(0)
  local errors = counts[vim.diagnostic.severity.ERROR] or 0
  local warnings = counts[vim.diagnostic.severity.WARN] or 0

  if errors == 0 and warnings == 0 then
    return ""
  end

  local parts = {}
  if errors > 0 then
    table.insert(parts, string.format("%%#StatuslineDiagnosticError#%s %d", icons.diagnostics.ERROR, errors))
  end
  if warnings > 0 then
    table.insert(parts, string.format("%%#StatuslineDiagnosticWarn#%s %d", icons.diagnostics.WARN, warnings))
  end

  return table.concat(parts, " ")
end

-- =============================================================================
-- FILETYPE COMPONENT
-- Shows filetype with icon
-- =============================================================================
function M.filetype_component()
  local filetype = vim.bo.filetype
  if filetype == "" then
    return "[No Name]"
  end

  -- Try to get icon from nvim-web-devicons
  local icon, icon_hl = "", "StatusLine"
  local ok, devicons = pcall(require, "nvim-web-devicons")
  if ok then
    local buf_name = vim.api.nvim_buf_get_name(0)
    local name = vim.fn.fnamemodify(buf_name, ":t")
    local ext = vim.fn.fnamemodify(buf_name, ":e")
    local i, hl = devicons.get_icon(name, ext)
    if i then
      icon, icon_hl = i, M.get_or_create_hl(hl)
    end
  end

  return string.format("%%#%s#%s %%#StatuslineTitle#%s", icon_hl, icon, filetype)
end

-- =============================================================================
-- POSITION COMPONENT
-- Shows line number, total lines, and column
-- =============================================================================
function M.position_component()
  local line = vim.fn.line(".")
  local line_count = vim.api.nvim_buf_line_count(0)
  local col = vim.fn.virtcol(".")

  return string.format(
    "%%#StatuslineItalic#l: %%#StatuslineTitle#%d%%#StatuslineItalic#/%d c: %d",
    line,
    line_count,
    col
  )
end

-- =============================================================================
-- RENDER
-- Combines all components into the final statusline
-- =============================================================================
function M.render()
  -- Left side
  local left = table.concat({
    M.mode_component(),
    -- M.git_component(),
    "  ",
    M.lsp_progress_component(),
  })

  -- Right side
  local right = table.concat({
    M.diagnostics_component(),
    "  ",
    M.filetype_component(),
    "  ",
    M.position_component(),
    " ",
  })

  -- Combine with spacer in middle
  return left .. "%#StatusLine#%=" .. right
end

-- Set the statusline
vim.o.statusline = "%!v:lua.require'statusline'.render()"

return M







