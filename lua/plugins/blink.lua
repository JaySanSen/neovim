-- ================================================================================================
-- TITLE : blink.cmp
-- LINKS :
--   > github : https://github.com/saghen/blink.cmp
-- ABOUT : Fast, minimal autocompletion plugin. Uses a Rust-based fuzzy matcher for performance.
--         Provides completions from LSP, buffer words, and file paths.
-- NOTE  : LSP completions won't work until you configure LSP servers!
-- ================================================================================================

return {
  "saghen/blink.cmp",

  -- No dependencies - keeping it minimal
  -- Snippets will be configured separately later

  -- Use a release tag to download pre-built Rust binary (recommended)
  -- This avoids needing to compile from source
  version = "1.*",

  -- Only load when entering insert mode (lazy loading for faster startup)
  event = "InsertEnter",

  -- ==============================================================================================
  -- OPTIONS
  -- ==============================================================================================
  opts = {

    -- ============================================================================================
    -- KEYMAP
    -- Controls how you interact with the completion menu
    -- Preset options: 'default', 'super-tab', 'enter', 'none'
    -- ============================================================================================
    keymap = {
      -- Using 'default' preset which includes:
      --   C-space : Open menu or open docs if already open
      --   C-n/C-p : Select next/previous item
      --   C-y     : Accept completion
      --   C-e     : Hide menu
      preset = "default",

      -- You can add custom keymaps on top of the preset:
      ['<CR>'] = { 'accept', 'fallback' },      -- Enter to accept
      -- ['<Tab>'] = { 'select_next', 'fallback' }, -- Tab to go to next item
      ['<A-.>'] = { 'select_prev', 'fallback' },      -- Enter to accept
      ['<A-,>'] = { 'select_next', 'fallback' },      -- Enter to accept
      ['<Tab>'] = { 'snippet_forward', 'fallback' },
      ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
    },

    -- ============================================================================================
    -- COMPLETION
    -- Controls the completion menu behavior and appearance
    -- ============================================================================================
    completion = {
      -- List behavior
      list = {
        -- max_items: Limit how many items show in the menu (less clutter)
        -- max_items = 10,

        -- selection:
        --   preselect: false = don't auto-select first item
        --   auto_insert: true = insert text as you navigate (like VSCode)
        selection = { preselect = false, auto_insert = true },
      },


      accept = {
        auto_brackets = { enabled = true },
      },

      -- Documentation popup (shows function signatures, descriptions)
      documentation = {
        -- auto_show: true = show docs automatically when item is selected
        -- Set to false if you find it distracting
        auto_show = true,
        auto_show_delay_ms = 200,
        window = {
          border = "rounded",
        }
      },

      -- Menu appearance
      menu = {
        -- Hide scrollbar for cleaner look
        border = "rounded",
        scrollbar = false,
      },

      ghost_text = { enabled = true },
    },


    signature = {
      enabled = true,
      window = {
        border = "rounded",
      },
    },

    -- ============================================================================================
    -- SOURCES
    -- Where completions come from. Order matters - earlier sources have higher priority.
    -- ============================================================================================
    sources = {
      -- Default sources for all filetypes:
      --   lsp    : Language Server Protocol (requires LSP to be configured!)
      --   path   : File/directory paths
      --   buffer : Words from current buffer
      -- NOTE: 'snippets' source removed - will be configured separately later
      default = { "lsp", "snippets", "path", "buffer" },
    },

    -- snippets = {
    --   search_paths = { vim.fn.stdpath("config") .. "/snippets" },
    -- },

    -- ============================================================================================
    -- FUZZY MATCHING
    -- How blink matches your input against completion candidates
    -- ============================================================================================
    fuzzy = {
      -- prefer_rust_with_warning: Use fast Rust implementation if available,
      -- otherwise fall back to Lua with a warning
      -- Other options: "prefer_rust", "lua"
      implementation = "prefer_rust_with_warning",
    },

    -- ============================================================================================
    -- APPEARANCE
    -- Visual settings for the completion menu
    -- ============================================================================================
    appearance = {
      -- 'mono' for Nerd Font Mono, 'normal' for regular Nerd Font
      -- Affects icon spacing
      nerd_font_variant = "mono",
      kind_icons = require("icons").symbol_kinds;
    },

    -- ============================================================================================
    -- COMMAND LINE COMPLETION
    -- Enable/disable completion in command mode (:)
    -- ============================================================================================
    cmdline = {
      -- Disable command line completion (can be noisy)
      -- Set to true if you want completions when typing : commands
      enabled = false,
    },
  },

  -- This allows other parts of your config to extend the sources list
  -- without having to redefine the entire list
  opts_extend = { "sources.default" },
}
