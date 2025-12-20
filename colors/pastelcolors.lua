-- ================================================================================================
-- COLORSCHEME: pastelcolors
-- Based on Catppuccin Mocha palette with pure black background
-- ================================================================================================

-- Reset everything
vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end
vim.o.termguicolors = true
vim.g.colors_name = "pastelcolors"

-- =============================================================================
-- COLOR PALETTE
-- =============================================================================
local c = {
  -- Backgrounds
  bg = "#000000",
  surface0 = "#313244",
  surface1 = "#45475a",
  surface2 = "#585b70",

  -- Foregrounds
  overlay0 = "#6c7086",
  overlay1 = "#7f849c",
  text = "#cdd6f4",
  fg = "#E4E4E4",

  -- Accent colors (pastel)
  red = "#f38ba8",
  maroon = "#eba0ac",
  peach = "#fab387",
  yellow = "#f9e2af",
  green = "#a6e3a1",
  teal = "#94e2d5",
  sky = "#89dceb",
  sapphire = "#74c7ec",
  blue = "#89b4fa",
  lavender = "#b4befe",
  mauve = "#cba6f7",
  pink = "#f5c2e7",

  -- Extras
  grey = "#5E5E5E",
}

-- =============================================================================
-- HELPER
-- =============================================================================
local function hi(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- =============================================================================
-- EDITOR UI
-- =============================================================================
hi("Normal", { fg = c.fg, bg = c.bg })
hi("NormalFloat", { fg = c.fg, bg = c.bg })
hi("FloatBorder", { fg = c.surface2, bg = c.bg })
hi("Cursor", { fg = c.bg, bg = c.pink })
hi("CursorLine", { bg = c.surface0 })
hi("CursorLineNr", { fg = c.fg, bold = true })
hi("LineNr", { fg = c.grey })
hi("SignColumn", { bg = c.bg })
hi("ColorColumn", { bg = c.surface0 })
hi("VertSplit", { fg = c.surface2 })
hi("WinSeparator", { fg = c.surface2 })
hi("StatusLine", { fg = c.fg, bg = c.bg })
hi("StatusLineNC", { fg = c.overlay0, bg = c.bg })
hi("Pmenu", { fg = c.fg, bg = c.bg })
hi("PmenuSel", { fg = c.text, bg = c.surface1 })
hi("PmenuSbar", { bg = c.surface0 })
hi("PmenuThumb", { bg = c.surface2 })
hi("Visual", { bg = c.surface1 })
hi("VisualNOS", { bg = c.surface1 })
hi("Search", { fg = c.bg, bg = c.peach })
hi("IncSearch", { fg = c.bg, bg = c.pink })
hi("CurSearch", { fg = c.bg, bg = c.pink })
hi("MatchParen", { fg = c.pink, bold = true, underline = true })
hi("Folded", { bg = c.surface0 })
hi("FoldColumn", {})
hi("EndOfBuffer", { fg = c.bg })
hi("NonText", { fg = c.surface2 })
hi("SpecialKey", { fg = c.surface2 })
hi("Directory", { fg = c.blue })
hi("Title", { fg = c.blue, bold = true })
hi("Question", { fg = c.blue })
hi("MoreMsg", { fg = c.fg, bold = true })
hi("MsgArea", { fg = c.text })
hi("ErrorMsg", { fg = c.red })
hi("WarningMsg", { fg = c.yellow })
hi("WildMenu", { fg = c.bg, bg = c.pink })

-- =============================================================================
-- SYNTAX HIGHLIGHTING
-- =============================================================================
hi("Comment", { fg = c.overlay0, italic = true })
hi("Constant", { fg = c.peach })
hi("String", { fg = c.green })
hi("Character", { fg = c.green })
hi("Number", { fg = c.peach })
hi("Boolean", { fg = c.peach })
hi("Float", { fg = c.peach })
hi("Identifier", { fg = c.text })
hi("Function", { fg = c.blue })
hi("Statement", { fg = c.mauve })
hi("Conditional", { fg = c.mauve })
hi("Repeat", { fg = c.mauve })
hi("Label", { fg = c.sapphire })
hi("Operator", { fg = c.sky })
hi("Keyword", { fg = c.mauve })
hi("Exception", { fg = c.mauve })
hi("PreProc", { fg = c.mauve })
hi("Include", { fg = c.mauve })
hi("Define", { fg = c.mauve })
hi("Macro", { fg = c.mauve })
hi("PreCondit", { fg = c.mauve })
hi("Type", { fg = c.yellow })
hi("StorageClass", { fg = c.mauve })
hi("Structure", { fg = c.yellow })
hi("Typedef", { fg = c.yellow })
hi("Special", { fg = c.pink })
hi("SpecialComment", { fg = c.overlay0, italic = true })
hi("Error", { fg = c.red })
hi("Todo", { fg = c.mauve, bold = true, italic = true })
hi("Underlined", { fg = c.blue, underline = true })
hi("Conceal", { fg = c.overlay0 })

-- =============================================================================
-- TREESITTER
-- =============================================================================
hi("@variable", { fg = c.text })
hi("@variable.builtin", { fg = c.mauve })
hi("@variable.parameter", { fg = c.maroon })
hi("@variable.member", { fg = c.blue })
hi("@constant", { fg = c.peach })
hi("@constant.builtin", { fg = c.peach })
hi("@constant.macro", { fg = c.mauve })
hi("@module", { fg = c.yellow })
hi("@label", { fg = c.sapphire })
hi("@string", { fg = c.green })
hi("@string.escape", { fg = c.pink })
hi("@string.regexp", { fg = c.pink })
hi("@string.special.symbol", { fg = c.teal })
hi("@character", { fg = c.green })
hi("@number", { fg = c.peach })
hi("@number.float", { fg = c.peach })
hi("@boolean", { fg = c.peach })
hi("@type", { fg = c.yellow })
hi("@type.builtin", { fg = c.yellow })
hi("@type.definition", { fg = c.yellow })
hi("@type.qualifier", { fg = c.mauve })
hi("@attribute", { fg = c.yellow })
hi("@property", { fg = c.blue })
hi("@function", { fg = c.blue })
hi("@function.builtin", { fg = c.blue })
hi("@function.macro", { fg = c.blue })
hi("@function.method", { fg = c.blue })
hi("@constructor", { fg = c.sapphire })
hi("@operator", { fg = c.sky })
hi("@keyword", { fg = c.mauve })
hi("@keyword.function", { fg = c.mauve })
hi("@keyword.operator", { fg = c.mauve })
hi("@keyword.return", { fg = c.mauve })
hi("@keyword.conditional", { fg = c.mauve })
hi("@keyword.repeat", { fg = c.mauve })
hi("@keyword.import", { fg = c.mauve })
hi("@keyword.exception", { fg = c.mauve })
hi("@punctuation.bracket", { fg = c.overlay1 })
hi("@punctuation.delimiter", { fg = c.overlay1 })
hi("@punctuation.special", { fg = c.sky })
hi("@comment", { fg = c.overlay0, italic = true })
hi("@tag", { fg = c.red })
hi("@tag.attribute", { fg = c.yellow })
hi("@tag.delimiter", { fg = c.overlay1 })
hi("@markup.heading", { fg = c.blue, bold = true })
hi("@markup.strong", { fg = c.peach, bold = true })
hi("@markup.emphasis", { fg = c.peach, italic = true })
hi("@markup.link", { fg = c.blue, underline = true })
hi("@markup.raw", { fg = c.green })
hi("@markup.list", { fg = c.red })
hi("@markup.quote", { fg = c.overlay1, italic = true })

-- =============================================================================
-- LSP SEMANTIC TOKENS
-- =============================================================================
hi("@lsp.type.class", { fg = c.yellow })
hi("@lsp.type.decorator", { fg = c.pink })
hi("@lsp.type.enum", { fg = c.yellow })
hi("@lsp.type.enumMember", { fg = c.teal })
hi("@lsp.type.function", { fg = c.blue })
hi("@lsp.type.interface", { fg = c.yellow })
hi("@lsp.type.macro", { fg = c.mauve })
hi("@lsp.type.method", { fg = c.blue })
hi("@lsp.type.namespace", { fg = c.yellow })
hi("@lsp.type.parameter", { fg = c.maroon })
hi("@lsp.type.property", { fg = c.blue })
hi("@lsp.type.struct", { fg = c.yellow })
hi("@lsp.type.type", { fg = c.yellow })
hi("@lsp.type.variable", { fg = c.text })

-- =============================================================================
-- DIAGNOSTICS
-- =============================================================================
hi("DiagnosticError", { fg = c.red })
hi("DiagnosticWarn", { fg = c.yellow })
hi("DiagnosticInfo", { fg = c.blue })
hi("DiagnosticHint", { fg = c.teal })
hi("DiagnosticUnderlineError", { undercurl = true, sp = c.red })
hi("DiagnosticUnderlineWarn", { undercurl = true, sp = c.yellow })
hi("DiagnosticUnderlineInfo", { undercurl = true, sp = c.blue })
hi("DiagnosticUnderlineHint", { undercurl = true, sp = c.teal })
hi("DiagnosticVirtualTextError", { fg = c.red, bg = "#2a1215" })
hi("DiagnosticVirtualTextWarn", { fg = c.yellow, bg = "#2a2517" })
hi("DiagnosticVirtualTextInfo", { fg = c.blue, bg = "#151d2a" })
hi("DiagnosticVirtualTextHint", { fg = c.teal, bg = "#172523" })
hi("DiagnosticUnnecessary", { fg = c.overlay0, italic = true })
hi("DiagnosticDeprecated", { strikethrough = true, fg = c.overlay0 })

-- =============================================================================
-- LSP
-- =============================================================================
hi("LspReferenceText", {})
hi("LspReferenceRead", { bg = "#151d2a" })
hi("LspReferenceWrite", { bg = "#1f1827" })
hi("LspSignatureActiveParameter", { bold = true, underline = true })
hi("LspInlayHint", { fg = c.overlay0, italic = true })
hi("LspCodeLens", { fg = c.overlay0, italic = true })

-- =============================================================================
-- DIFFS
-- =============================================================================
hi("DiffAdd", { fg = c.green, bg = "#1a251a" })
hi("DiffChange", { fg = c.yellow, bg = "#2a2517" })
hi("DiffDelete", { fg = c.red, bg = "#2a1215" })
hi("DiffText", { fg = c.peach, bg = "#2a2517", bold = true })
hi("diffAdded", { fg = c.green, bold = true })
hi("diffChanged", { fg = c.yellow, bold = true })
hi("diffRemoved", { fg = c.red, bold = true })

-- =============================================================================
-- SPELLING
-- =============================================================================
hi("SpellBad", { sp = c.red, undercurl = true })
hi("SpellCap", { sp = c.yellow, undercurl = true })
hi("SpellLocal", { sp = c.blue, undercurl = true })
hi("SpellRare", { sp = c.green, undercurl = true })

-- =============================================================================
-- GITSIGNS
-- =============================================================================
hi("GitSignsAdd", { fg = c.green })
hi("GitSignsChange", { fg = c.yellow })
hi("GitSignsDelete", { fg = c.red })
hi("GitSignsCurrentLineBlame", { fg = c.overlay0 })

-- =============================================================================
-- FZF-LUA
-- =============================================================================
hi("FzfLuaNormal", { fg = c.fg, bg = c.bg })
hi("FzfLuaBorder", { fg = c.surface2 })
hi("FzfLuaTitle", { fg = c.lavender, bold = true })
hi("FzfLuaPreviewTitle", { fg = c.fg })
hi("FzfLuaCursorLine", { bg = c.surface1 })
hi("FzfLuaSearch", { fg = c.bg, bg = c.yellow, bold = true })

-- =============================================================================
-- BLINK.CMP (Completion)
-- =============================================================================
hi("BlinkCmpMenu", { bg = c.bg })
hi("BlinkCmpMenuBorder", { fg = c.mauve, bg = c.bg })
hi("BlinkCmpLabelDescription", { fg = c.overlay0, italic = true })
hi("BlinkCmpLabelDeprecated", { fg = c.overlay0, strikethrough = true })
hi("BlinkCmpKindFunction", { fg = c.blue })
hi("BlinkCmpKindMethod", { fg = c.blue })
hi("BlinkCmpKindVariable", { fg = c.text })
hi("BlinkCmpKindKeyword", { fg = c.mauve })
hi("BlinkCmpKindClass", { fg = c.yellow })
hi("BlinkCmpKindStruct", { fg = c.yellow })
hi("BlinkCmpKindInterface", { fg = c.yellow })
hi("BlinkCmpKindModule", { fg = c.yellow })
hi("BlinkCmpKindProperty", { fg = c.blue })
hi("BlinkCmpKindField", { fg = c.blue })
hi("BlinkCmpKindConstant", { fg = c.peach })
hi("BlinkCmpKindEnum", { fg = c.yellow })
hi("BlinkCmpKindEnumMember", { fg = c.teal })
hi("BlinkCmpKindSnippet", { fg = c.pink })
hi("BlinkCmpKindText", { fg = c.text })
hi("BlinkCmpKindFile", { fg = c.blue })
hi("BlinkCmpKindFolder", { fg = c.blue })

-- =============================================================================
-- LAZY.NVIM
-- =============================================================================
hi("LazyDimmed", { fg = c.overlay0 })

-- =============================================================================
-- FLASH.NVIM
-- =============================================================================
hi("FlashBackdrop", { italic = true })
hi("FlashLabel", { fg = c.bg, bg = c.pink, bold = true })
hi("FlashMatch", { fg = c.peach, bg = c.surface0 })
hi("FlashCurrent", { fg = c.yellow, bg = c.surface0 })

-- =============================================================================
-- INDENT-BLANKLINE
-- =============================================================================
hi("IblIndent", { fg = c.surface1 })
hi("IblScope", { fg = c.lavender })

-- =============================================================================
-- WINBAR
-- =============================================================================
hi("WinBar", { fg = c.fg, bg = c.bg })
hi("WinBarNC", { bg = c.bg })

-- =============================================================================
-- QUICKFIX
-- =============================================================================
hi("QuickFixLine", { italic = true, bg = "#1f1827" })


-- =============================================================================
-- STATUSLINE
-- =============================================================================
-- Mode highlights (colored backgrounds)
hi("StatuslineModeNormal", { fg = c.bg, bg = c.mauve, bold = true })
hi("StatuslineModePending", { fg = c.bg, bg = c.pink, bold = true })
hi("StatuslineModeVisual", { fg = c.bg, bg = c.yellow, bold = true })
hi("StatuslineModeInsert", { fg = c.bg, bg = c.green, bold = true })
hi("StatuslineModeCommand", { fg = c.bg, bg = c.sky, bold = true })
hi("StatuslineModeOther", { fg = c.bg, bg = c.peach, bold = true })

-- Text styles for statusline
hi("StatuslineTitle", { fg = c.fg, bg = c.bg, bold = true })
hi("StatuslineItalic", { fg = c.overlay1, bg = c.bg, italic = true })
hi("StatuslineSpinner", { fg = c.green, bg = c.bg, bold = true })


hi("StatuslineDiagnosticError", { fg = c.red, bg = c.bg, bold = true })
hi("StatuslineDiagnosticWarn", { fg = c.yellow, bg = c.bg, bold = true })
hi("StatuslineDiagnosticInfo", { fg = c.blue, bg = c.bg, bold = true })
hi("StatuslineDiagnosticHint", { fg = c.teal, bg = c.bg, bold = true })

-- =============================================================================
-- TERMINAL COLORS
-- =============================================================================
vim.g.terminal_color_0 = c.surface0
vim.g.terminal_color_1 = c.red
vim.g.terminal_color_2 = c.green
vim.g.terminal_color_3 = c.yellow
vim.g.terminal_color_4 = c.blue
vim.g.terminal_color_5 = c.mauve
vim.g.terminal_color_6 = c.teal
vim.g.terminal_color_7 = c.text
vim.g.terminal_color_8 = c.overlay0
vim.g.terminal_color_9 = c.red
vim.g.terminal_color_10 = c.green
vim.g.terminal_color_11 = c.yellow
vim.g.terminal_color_12 = c.blue
vim.g.terminal_color_13 = c.mauve
vim.g.terminal_color_14 = c.teal
vim.g.terminal_color_15 = c.fg

