return {
  'stevearc/oil.nvim',
  opts = {
    -- Floating window configuration
    float = {
      padding = 2,
      max_width = 0.5,   -- Set the max width to 50% of the screen
      max_height = 0.5,  -- Set the max height to 50% of the screen
      border = "rounded", -- Optional: rounded corners for the floating window
      win_options = {
        winblend = 10,    -- Set the transparency of the window
      },
    },

    -- Basic file explorer settings
    default_file_explorer = true,  -- Oil will handle directory buffers
    columns = {
      "icon",   -- Show file icons
    },

    -- Minimal buffer-local options
    buf_options = {
      buflisted = false,
      bufhidden = "hide",
    },

    -- Minimal window-local options
    win_options = {
      wrap = false,      -- Disable text wrapping
      signcolumn = "no", -- Hide the sign column
      cursorcolumn = false,  -- Disable cursor column highlighting
      foldcolumn = "0",  -- Disable fold column
      spell = false,     -- Disable spell check
      list = false,      -- Disable list chars
    },

    -- Keymaps configuration (minimal setup)
    keymaps = {
      -- Keymap to close the oil window
      ["q"] = { "actions.close", mode = "n" },   -- Close the oil window with 'q'
    },

    -- Automatically delete hidden buffers after a delay
    cleanup_delay_ms = 2000,

    -- Don't show hidden files by default
    view_options = {
      show_hidden = false,
    },
  },

  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- Use nvim-web-devicons if you want file icons

  -- Lazy loading is not recommended because it is tricky to make it work correctly in all situations
  lazy = false,
}
