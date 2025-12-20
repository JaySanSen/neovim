-- ================================================================================================
-- TITLE : fzf-lua
-- LINKS :
--   > github : https://github.com/ibhagwan/fzf-lua
-- ABOUT : lua-based fzf wrapper and integration.
-- ================================================================================================

return {
  "ibhagwan/fzf-lua",
  lazy = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    {
      "<leader>ff",
      function()
        require("fzf-lua").files()
      end,
      desc = "FZF Files",
    },
    {
      "<leader>fg",
      function()
        require("fzf-lua").live_grep()
      end,
      desc = "FZF Live Grep",
    },
    {
      "<leader>fb",
      function()
        require("fzf-lua").buffers()
      end,
      desc = "FZF Buffers",
    },
    {
      "<leader>fh",
      function()
        require("fzf-lua").help_tags()
      end,
      desc = "FZF Help Tags",
    },
    {
      "<leader>fx",
      function()
        require("fzf-lua").diagnostics_document()
      end,
      desc = "FZF Diagnostics Document",
    },
    {
      "<leader>fX",
      function()
        require("fzf-lua").diagnostics_workspace()
      end,
      desc = "FZF Diagnostics Workspace",
    },
    {
      "<leader>fs",
      function()
        require("fzf-lua").lsp_document_symbols()
      end,
      desc = "FZF Document Symbols",
    },
    {
      "<leader>fS",
      function()
        require("fzf-lua").lsp_workspace_symbols()
      end,
      desc = "FZF Workspace Symbols",
    },
  },
  opts = {

    -- ============================================================================================
    -- FZF COLORS
    -- Maps fzf's color slots to Neovim highlight groups. This makes fzf match your colorscheme.
    -- Format: ["fzf-color-name"] = { "fg" or "bg", "HighlightGroupName" }
    -- ============================================================================================
    fzf_colors = {
      ["fg"] = { "fg", "Normal" },           -- Default text color
      ["bg"] = { "bg", "Normal" },           -- Background color
      ["hl"] = { "fg", "Comment" },          -- Highlighted matches (not selected)
      ["fg+"] = { "fg", "CursorLine" },      -- Text color of selected line
      ["bg+"] = { "bg", "CursorLine" },      -- Background of selected line
      ["hl+"] = { "fg", "Statement" },       -- Highlighted matches on selected line
      ["info"] = { "fg", "Conditional" },    -- Info line (match count, etc)
      ["prompt"] = { "fg", "Function" },     -- Prompt text color (the "> " part)
      ["pointer"] = { "fg", "Exception" },   -- Pointer arrow on selected line
      ["marker"] = { "fg", "Keyword" },      -- Multi-select marker
      ["spinner"] = { "fg", "Label" },       -- Loading spinner
      ["header"] = { "fg", "Comment" },      -- Header text (keybind hints)
      ["gutter"] = { "bg", "Normal" },       -- Gutter background (left side)
      ["scrollbar"] = { "bg", "Normal" },    -- Scrollbar color
      ["separator"] = { "fg", "Comment" },   -- Separator line color
    },

    -- ============================================================================================
    -- FZF OPTIONS
    -- Command-line flags passed directly to the fzf binary
    -- See `man fzf` or `fzf --help` for all available options
    -- ============================================================================================
    fzf_opts = {
      -- Show match count and other info at the bottom
      ["--info"] = "default",

      -- Layout: where the prompt and results appear
      -- "reverse-list": prompt at top, results below growing upward (newest at bottom)
      -- "reverse": prompt at top, results below growing downward
      -- "default": prompt at bottom
      ["--layout"] = "reverse-list",
    },

    -- ============================================================================================
    -- KEYMAPS (inside the fzf picker window)
    -- These work AFTER you've opened a picker (e.g., after <leader>ff)
    -- "builtin" = handled by fzf-lua's Lua code
    -- "fzf" = passed directly to fzf binary
    -- ============================================================================================
    keymap = {
      -- Builtin keymaps (handled by fzf-lua)
      builtin = {
        -- Show/hide a help popup with all available keybinds for current picker
        ["<C-/>"] = "toggle-help",

        -- Toggle fullscreen mode for the picker window
        ["<C-a>"] = "toggle-fullscreen",

        -- Show/hide the preview pane (file contents, grep context, etc)
        ["<C-i>"] = "toggle-preview",
      },

      -- FZF native keymaps (passed to fzf binary)
      fzf = {
        -- Toggle selection on current item (for multi-select operations)
        ["alt-s"] = "toggle",

        -- Toggle selection on ALL items (select all / deselect all)
        ["alt-a"] = "toggle-all",

        -- Toggle preview (fzf's native implementation)
        ["ctrl-i"] = "toggle-preview",


        ["alt-,"] = "down",
        ["alt-."] = "up",
      },
    },

    -- ============================================================================================
    -- DEFAULTS
    -- Settings applied to ALL pickers unless overridden in picker-specific config
    -- ============================================================================================
    defaults = {
      -- Disable git status icons (M for modified, ? for untracked, etc)
      -- Keeps the UI cleaner and slightly faster
      git_icons = false,
    },


    -- ============================================================================================
    -- PREVIEWER OPTIONS
    -- Controls the preview window appearance
    -- ============================================================================================

    previewers = {
      builtin = {
        cursorline = false,
      },
    },


    -- ============================================================================================
    -- PICKER-SPECIFIC OPTIONS
    -- Override defaults for individual pickers
    -- ============================================================================================

    -- FILES PICKER (<leader>ff)
    -- Uses `fd` command by default, falls back to `find` if fd not installed
    files = {
      -- fd command options:
      -- --color=never    : no color codes in output (fzf-lua handles colors)
      -- --type f         : only find files (not directories)
      -- --hidden         : include hidden files (dotfiles like .gitignore)
      -- --follow         : follow symlinks
      -- --exclude .git   : ignore .git directory
      fd_opts = "--color=never --type f --hidden --follow --exclude .git",
    },

    file_ignore_patterns = {
      "node_modules/",
      -- "dist/",
      -- ".next/",
      -- ".git/",
      -- ".gitlab/",
      -- "build/",
      -- "target/",
      -- "package-lock.json",
      -- "pnpm-lock.yaml",
      -- "yarn.lock",
    },

    -- GREP PICKER (<leader>fg)
    -- Uses `ripgrep` (rg) for fast text searching
    grep = {
      -- Include hidden files in search
      hidden = true,

      -- ripgrep command options:
      -- --column          : show column number of match
      -- --line-number     : show line numbers
      -- --no-heading      : don't group by file (one result per line)
      -- --color=always    : colorize output
      -- --smart-case      : case-insensitive unless query has uppercase
      -- --hidden          : search hidden files
      -- -g '!.git'        : exclude .git directory
      -- -e                : pattern follows (required at end)
      rg_opts = "--column --line-number --no-heading --color=always --smart-case --hidden -g '!.git' -e",
    },

    -- OLDFILES PICKER (<leader>fr)
    -- Shows recently opened files
    oldfiles = {
      -- Also include files opened in the current Neovim session
      -- (not just files from previous sessions stored in shada/viminfo)
      include_current_session = true,
    },
  },

}
