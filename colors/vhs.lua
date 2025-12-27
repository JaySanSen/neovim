
-- ================================================================================================
-- COLORSCHEME: vhs
-- Based on VHS Era/IBM Carbon theme with dark background
-- ================================================================================================

-- Reset everything
vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end
vim.o.termguicolors = true
vim.g.colors_name = "vhs"

-- =============================================================================
-- COLOR PALETTE
-- =============================================================================
local c = {
  -- Backgrounds
  bg = "#161616",
  bgFloat = "#131313",
  surface0 = "#252525",
  surface1 = "#353535",
  surface2 = "#484848",

  -- Foregrounds
  overlay0 = "#525252",
  overlay1 = "#6f6f6f",
  text = "#f2f4f8",
  fg = "#f2f4f8",

  -- Accent colors (VHS/IBM Carbon inspired)
  red = "#ee5396",       -- parameter, delete
  pink = "#ff7eb6",      -- method, function, error
  peach = "#ffcc66",     -- diffChange
  yellow = "#ffcc66",    -- changed
  green = "#42be65",     -- constant, added
  teal = "#08bdba",      -- attribute, label
  cyan = "#3ddbd9",      -- punctuation, tag
  sky = "#82cfff",       -- number, hint
  blue = "#78a9ff",      -- keyword, type, primary
  lavender = "#be95ff",  -- string, warning
  mauve = "#be95ff",     -- string (alias)
  property = "#33b1ff",  -- property

  -- Extras
  grey = "#525252",
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
hi("NormalFloat", { fg = c.fg, bg = c.bgFloat })
hi("FloatBorder", { fg = c.cyan, bg = c.bgFloat })
hi("Cursor", { fg = c.bg, bg = c.fg })
hi("CursorLine", { bg = c.surface0 })
hi("CursorLineNr", { fg = c.fg, bold = true })
hi("LineNr", { fg = c.grey })
hi("SignColumn", { bg = c.bg })
hi("ColorColumn", { bg = c.surface0 })
hi("VertSplit", { fg = c.surface2 })
hi("WinSeparator", { fg = c.surface2 })
hi("StatusLine", { fg = c.fg, bg = c.bg })
hi("StatusLineNC", { fg = c.overlay0, bg = c.bg })
hi("Pmenu", { fg = c.fg, bg = c.bgFloat })
hi("PmenuSel", { fg = c.text, bg = c.surface1 })
hi("PmenuSbar", { bg = c.surface0 })
hi("PmenuThumb", { bg = c.surface2 })
hi("Visual", { bg = c.surface1 })
hi("VisualNOS", { bg = c.surface1 })
hi("Search", { fg = c.bg, bg = c.cyan })
hi("IncSearch", { fg = c.bg, bg = c.pink })
hi("CurSearch", { fg = c.bg, bg = c.pink })
hi("MatchParen", { fg = c.bg, bg = c.cyan })
hi("Folded", { fg = c.cyan, bg = c.surface0 })
hi("FoldColumn", {})
hi("EndOfBuffer", { fg = c.bg })
hi("NonText", { fg = c.surface2 })
hi("SpecialKey", { fg = c.surface2 })
hi("Directory", { fg = c.blue })
hi("Title", { fg = c.blue, bold = true })
hi("Question", { fg = c.blue })
hi("MoreMsg", { fg = c.fg, bold = true })
hi("MsgArea", { fg = c.text })
hi("ErrorMsg", { fg = c.pink })
hi("WarningMsg", { fg = c.lavender })
hi("WildMenu", { fg = c.bg, bg = c.pink })

-- =============================================================================
-- SYNTAX HIGHLIGHTING
-- =============================================================================
hi("Comment", { fg = c.overlay0, italic = true })
hi("Constant", { fg = c.green })
hi("String", { fg = c.lavender })
hi("Character", { fg = c.teal })
hi("Number", { fg = c.sky })
hi("Boolean", { fg = c.blue })
hi("Float", { fg = c.sky })
hi("Identifier", { fg = c.text })
hi("Function", { fg = c.pink })
hi("Statement", { fg = c.blue })
hi("Conditional", { fg = c.blue })
hi("Repeat", { fg = c.blue })
hi("Label", { fg = c.teal })
hi("Operator", { fg = c.cyan })
hi("Keyword", { fg = c.blue })
hi("Exception", { fg = c.blue })
hi("PreProc", { fg = c.blue })
hi("Include", { fg = c.blue })
hi("Define", { fg = c.blue })
hi("Macro", { fg = c.blue })
hi("PreCondit", { fg = c.blue })
hi("Type", { fg = c.blue })
hi("StorageClass", { fg = c.blue })
hi("Structure", { fg = c.blue })
hi("Typedef", { fg = c.blue })
hi("Special", { fg = c.teal })
hi("SpecialComment", { fg = c.overlay0, italic = true })
hi("Error", { fg = c.pink })
hi("Todo", { fg = c.blue, bold = true, italic = true })
hi("Underlined", { fg = c.blue, underline = true })
hi("Conceal", { fg = c.overlay0 })

-- =============================================================================
-- TREESITTER
-- =============================================================================
hi("@variable", { fg = c.text })
hi("@variable.builtin", { fg = c.blue })
hi("@variable.parameter", { fg = c.red })
hi("@variable.member", { fg = c.property })
hi("@constant", { fg = c.green })
hi("@constant.builtin", { fg = c.blue })
hi("@constant.macro", { fg = c.blue })
hi("@module", { fg = c.blue })
hi("@label", { fg = c.teal })
hi("@string", { fg = c.lavender })
hi("@string.escape", { fg = c.teal })
hi("@string.regexp", { fg = c.teal })
hi("@string.special.symbol", { fg = c.green })
hi("@character", { fg = c.teal })
hi("@number", { fg = c.sky })
hi("@number.float", { fg = c.sky })
hi("@boolean", { fg = c.blue })
hi("@type", { fg = c.blue })
hi("@type.builtin", { fg = c.blue })
hi("@type.definition", { fg = c.blue })
hi("@type.qualifier", { fg = c.blue })
hi("@attribute", { fg = c.teal })
hi("@property", { fg = c.property })
hi("@function", { fg = c.pink })
hi("@function.builtin", { fg = c.pink })
hi("@function.macro", { fg = c.pink })
hi("@function.method", { fg = c.pink })
hi("@constructor", { fg = c.blue })
hi("@operator", { fg = c.cyan })
hi("@keyword", { fg = c.blue })
hi("@keyword.function", { fg = c.blue })
hi("@keyword.operator", { fg = c.blue })
hi("@keyword.return", { fg = c.blue })
hi("@keyword.conditional", { fg = c.blue })
hi("@keyword.repeat", { fg = c.blue })
hi("@keyword.import", { fg = c.blue })
hi("@keyword.exception", { fg = c.blue })
hi("@punctuation.bracket", { fg = c.cyan })
hi("@punctuation.delimiter", { fg = c.cyan })
hi("@punctuation.special", { fg = c.cyan })
hi("@comment", { fg = c.overlay0, italic = true })
hi("@tag", { fg = c.cyan })
hi("@tag.attribute", { fg = c.teal })
hi("@tag.delimiter", { fg = c.cyan })
hi("@markup.heading", { fg = c.blue, bold = true })
hi("@markup.strong", { fg = c.pink, bold = true })
hi("@markup.emphasis", { fg = c.pink, italic = true })
hi("@markup.link", { fg = c.blue, underline = true })
hi("@markup.raw", { fg = c.lavender })
hi("@markup.list", { fg = c.cyan })
hi("@markup.quote", { fg = c.overlay1, italic = true })

-- =============================================================================
-- LSP SEMANTIC TOKENS
-- =============================================================================
hi("@lsp.type.class", { fg = c.blue })
hi("@lsp.type.decorator", { fg = c.teal })
hi("@lsp.type.enum", { fg = c.blue })
hi("@lsp.type.enumMember", { fg = c.green })
hi("@lsp.type.function", { fg = c.pink })
hi("@lsp.type.interface", { fg = c.blue })
hi("@lsp.type.macro", { fg = c.teal })
hi("@lsp.type.method", { fg = c.pink })
hi("@lsp.type.namespace", { fg = c.blue })
hi("@lsp.type.parameter", { fg = c.red })
hi("@lsp.type.property", { fg = c.property })
hi("@lsp.type.struct", { fg = c.blue })
hi("@lsp.type.type", { fg = c.blue })
hi("@lsp.type.variable", { fg = c.text })

-- =============================================================================
-- DIAGNOSTICS
-- =============================================================================
hi("DiagnosticError", { fg = c.pink })
hi("DiagnosticWarn", { fg = c.lavender })
hi("DiagnosticInfo", { fg = c.blue })
hi("DiagnosticHint", { fg = c.sky })
hi("DiagnosticUnderlineError", { undercurl = true, sp = c.pink })
hi("DiagnosticUnderlineWarn", { undercurl = true, sp = c.lavender })
hi("DiagnosticUnderlineInfo", { undercurl = true, sp = c.blue })
hi("DiagnosticUnderlineHint", { undercurl = true, sp = c.sky })
hi("DiagnosticVirtualTextError", { fg = c.pink, bg = "#2d1a24" })
hi("DiagnosticVirtualTextWarn", { fg = c.lavender, bg = "#2a2433" })
hi("DiagnosticVirtualTextInfo", { fg = c.blue, bg = "#1a2333" })
hi("DiagnosticVirtualTextHint", { fg = c.sky, bg = "#1a2833" })
hi("DiagnosticUnnecessary", { fg = c.overlay0, italic = true })
hi("DiagnosticDeprecated", { strikethrough = true, fg = c.overlay0 })

-- =============================================================================
-- LSP
-- =============================================================================
hi("LspReferenceText", {})
hi("LspReferenceRead", { bg = "#1a2333" })
hi("LspReferenceWrite", { bg = "#2d1a24" })
hi("LspSignatureActiveParameter", { bold = true, underline = true })
hi("LspInlayHint", { fg = c.overlay0, italic = true })
hi("LspCodeLens", { fg = c.overlay0, italic = true })

-- =============================================================================
-- DIFFS
-- =============================================================================
hi("DiffAdd", { fg = c.green, bg = "#1a2a1a" })
hi("DiffChange", { fg = c.yellow, bg = "#2a2517" })
hi("DiffDelete", { fg = c.red, bg = "#2d1a24" })
hi("DiffText", { fg = c.peach, bg = "#2a2517", bold = true })
hi("diffAdded", { fg = c.green, bold = true })
hi("diffChanged", { fg = c.yellow, bold = true })
hi("diffRemoved", { fg = c.red, bold = true })

-- =============================================================================
-- SPELLING
-- =============================================================================
hi("SpellBad", { sp = c.pink, undercurl = true })
hi("SpellCap", { sp = c.lavender, undercurl = true })
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
hi("FzfLuaNormal", { fg = c.fg, bg = c.bgFloat })
hi("FzfLuaBorder", { fg = c.cyan })
hi("FzfLuaTitle", { fg = c.blue, bold = true })
hi("FzfLuaPreviewTitle", { fg = c.fg })
hi("FzfLuaCursorLine", { bg = c.surface1 })
hi("FzfLuaSearch", { fg = c.bg, bg = c.cyan, bold = true })

-- =============================================================================
-- BLINK.CMP (Completion)
-- =============================================================================
hi("BlinkCmpMenu", { bg = c.bgFloat })
hi("BlinkCmpMenuBorder", { fg = c.blue, bg = c.bgFloat })
hi("BlinkCmpLabelDescription", { fg = c.overlay0, italic = true })
hi("BlinkCmpLabelDeprecated", { fg = c.overlay0, strikethrough = true })
hi("BlinkCmpKindFunction", { fg = c.pink })
hi("BlinkCmpKindMethod", { fg = c.pink })
hi("BlinkCmpKindVariable", { fg = c.text })
hi("BlinkCmpKindKeyword", { fg = c.blue })
hi("BlinkCmpKindClass", { fg = c.blue })
hi("BlinkCmpKindStruct", { fg = c.blue })
hi("BlinkCmpKindInterface", { fg = c.blue })
hi("BlinkCmpKindModule", { fg = c.blue })
hi("BlinkCmpKindProperty", { fg = c.property })
hi("BlinkCmpKindField", { fg = c.property })
hi("BlinkCmpKindConstant", { fg = c.green })
hi("BlinkCmpKindEnum", { fg = c.blue })
hi("BlinkCmpKindEnumMember", { fg = c.green })
hi("BlinkCmpKindSnippet", { fg = c.teal })
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
hi("FlashMatch", { fg = c.cyan, bg = c.surface0 })
hi("FlashCurrent", { fg = c.yellow, bg = c.surface0 })

-- =============================================================================
-- INDENT-BLANKLINE
-- =============================================================================
hi("IblIndent", { fg = c.surface1 })
hi("IblScope", { fg = c.blue })

-- =============================================================================
-- WINBAR
-- =============================================================================
hi("WinBar", { fg = c.fg, bg = c.bg })
hi("WinBarNC", { bg = c.bg })

-- =============================================================================
-- QUICKFIX
-- =============================================================================
hi("QuickFixLine", { italic = true, bg = "#1a2333" })

-- =============================================================================
-- STATUSLINE
-- =============================================================================
-- Mode highlights (colored backgrounds)
hi("StatuslineModeNormal", { fg = c.bg, bg = c.blue, bold = true })
hi("StatuslineModePending", { fg = c.bg, bg = c.pink, bold = true })
hi("StatuslineModeVisual", { fg = c.bg, bg = c.yellow, bold = true })
hi("StatuslineModeInsert", { fg = c.bg, bg = c.green, bold = true })
hi("StatuslineModeCommand", { fg = c.bg, bg = c.cyan, bold = true })
hi("StatuslineModeOther", { fg = c.bg, bg = c.lavender, bold = true })

-- Text styles for statusline
hi("StatuslineTitle", { fg = c.fg, bg = c.bg, bold = true })
hi("StatuslineItalic", { fg = c.overlay1, bg = c.bg, italic = true })
hi("StatuslineSpinner", { fg = c.green, bg = c.bg, bold = true })

hi("StatuslineDiagnosticError", { fg = c.pink, bg = c.bg, bold = true })
hi("StatuslineDiagnosticWarn", { fg = c.lavender, bg = c.bg, bold = true })
hi("StatuslineDiagnosticInfo", { fg = c.blue, bg = c.bg, bold = true })
hi("StatuslineDiagnosticHint", { fg = c.sky, bg = c.bg, bold = true })

-- =============================================================================
-- OIL.NVIM
-- =============================================================================
hi("OilDir", { fg = c.blue })
hi("OilDirIcon", { fg = c.blue })
hi("OilFile", { fg = c.fg })
hi("OilLink", { fg = c.cyan })
hi("OilLinkTarget", { fg = c.overlay0, italic = true })
hi("OilCreate", { fg = c.green })
hi("OilDelete", { fg = c.red })
hi("OilMove", { fg = c.yellow })
hi("OilCopy", { fg = c.green })
hi("OilChange", { fg = c.yellow })

-- =============================================================================
-- MINI.PAIRS / MINI.SURROUND
-- =============================================================================
hi("MiniSurround", { fg = c.bg, bg = c.cyan })

-- =============================================================================
-- TERMINAL COLORS
-- =============================================================================
vim.g.terminal_color_0 = c.surface0
vim.g.terminal_color_1 = c.red
vim.g.terminal_color_2 = c.green
vim.g.terminal_color_3 = c.yellow
vim.g.terminal_color_4 = c.blue
vim.g.terminal_color_5 = c.lavender
vim.g.terminal_color_6 = c.cyan
vim.g.terminal_color_7 = c.text
vim.g.terminal_color_8 = c.overlay0
vim.g.terminal_color_9 = c.red
vim.g.terminal_color_10 = c.green
vim.g.terminal_color_11 = c.yellow
vim.g.terminal_color_12 = c.blue
vim.g.terminal_color_13 = c.lavender
vim.g.terminal_color_14 = c.cyan
vim.g.terminal_color_15 = c.fg
