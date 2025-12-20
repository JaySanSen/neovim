return {
  'stevearc/oil.nvim',
  opts = {
    -- Oil will handle directory buffers
    default_file_explorer = true,

    -- Send files to trash instead of permanent delete
    delete_to_trash = true,

    -- Skip confirmation for simple operations
    skip_confirm_for_simple_edits = true,

    -- Keep cursor on editable parts like file names and not the icon column
    constrain_cursor = "editable",

    -- LSP integration: auto-update imports when renaming files
    lsp_file_methods = {
      enabled = true,
      timeout_ms = 1000,
      autosave_changes = "unmodified",
    },


    buf_options = {
      buflisted = false,
      bufhidden= "hide",
    },

    win_options = {
      wrap = false,
      signcolumn = "no",
      cursorcolumn = false,
      foldcolumn = "0",
      spell = false,
      list = false,
      conceallevel = 3,
      concealcursor = "nvic",
   },

   use_default_keymaps = true,
   keymaps = {
     ["q"] = { "actions.close", mode = "n" },
   },


   cleanup_delay_ms = 2000,

   view_options = {
     show_hidden = false,
     natural_order = "fast",
   },

   -- floating window configuration
   float = {
     padding = 2,
     max_width = 0.5,
     max_height = 0.5,
     border = "rounded",
     win_options = {
       winblend = 10,
     },
   },


   -- confirmation window configuration
   confirmation = {
     max_width = 0.4,
     min_width = { 30, 0.3 },
     max_height = 0.3,
     min_height = { 30, 0.1 },
     border = "rounded",
     win_options = {
       winblend = 10,
     },

   },

  },

  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- Use nvim-web-devicons if you want file icons

  -- Lazy loading is not recommended because it is tricky to make it work correctly in all situations
  lazy = false,
}
