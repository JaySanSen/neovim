-- ================================================================================================
-- TITLE : Autocommands
-- ABOUT : Commands that run automatically when specific events occur in Neovim.
--         Each autocmd belongs to an "augroup" to prevent duplicates on config reload.
-- ================================================================================================

-- ================================================================================================
-- SYNTAX REFERENCE
-- ================================================================================================
--
-- AUGROUP: A named container that prevents autocmd duplicates on config reload.
--          `clear = true` means: "Delete all existing autocmds in this group before adding new ones"
--
-- AUTOCMD: "When EVENT happens, run CALLBACK"
--
-- ------------------------------------------------------------------------------------------------
-- METHOD 1: Create augroup and autocmd TOGETHER (inline) - Recommended for single autocmds
-- ------------------------------------------------------------------------------------------------
--
--   vim.api.nvim_create_autocmd("EVENT_NAME", {
--     group = vim.api.nvim_create_augroup("group_name", { clear = true }),
--     desc = "Description of what this does",
--     pattern = "*.lua",              -- Optional: file pattern filter
--     callback = function(args)
--       -- args.buf = buffer number
--       -- args.file = file path
--       -- args.event = event name
--       -- Your code here
--     end,
--   })
--
-- ------------------------------------------------------------------------------------------------
-- METHOD 2: Create augroup SEPARATELY (reusable) - Recommended for multiple related autocmds
-- ------------------------------------------------------------------------------------------------
--
--   -- First, create the group once
--   local my_group = vim.api.nvim_create_augroup("group_name", { clear = true })
--
--   -- Then, add multiple autocmds to the same group
--   vim.api.nvim_create_autocmd("InsertEnter", {
--     group = my_group,
--     callback = function() ... end,
--   })
--
--   vim.api.nvim_create_autocmd("InsertLeave", {
--     group = my_group,
--     callback = function() ... end,
--   })
--
-- ------------------------------------------------------------------------------------------------
-- COMMON EVENTS
-- ------------------------------------------------------------------------------------------------
--
--   BufReadPost   - After reading a file into buffer
--   BufWritePre   - Before saving a file
--   BufWritePost  - After saving a file
--   BufEnter      - When entering a buffer
--   BufLeave      - When leaving a buffer
--   FileType      - When filetype is set (pattern = filetype name like "lua", "python")
--   InsertEnter   - When entering insert mode
--   InsertLeave   - When leaving insert mode
--   TextYankPost  - After yanking (copying) text
--   VimEnter      - When Neovim starts
--   VimResized    - When terminal window is resized
--   FocusGained   - When Neovim window gains focus
--   FocusLost     - When Neovim window loses focus
--   LspAttach     - When an LSP server attaches to a buffer
--
-- ================================================================================================

-- ================================================================================================
-- YANK HIGHLIGHT
-- Briefly highlights the text you just yanked (copied) so you can see what was copied.
-- ================================================================================================
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("user/yank_highlight", { clear = true }),
  desc = "Highlight text when yanked (copied)",
  callback = function()
    -- 'Visual' is the highlight group used (same as visual selection)
    -- You could also use 'IncSearch' or any other highlight group
    vim.hl.on_yank({ higroup = "Visual", timeout = 200 })
  end,
})

-- ================================================================================================
-- RESTORE CURSOR POSITION
-- When you reopen a file, jump to the last position you were at.
-- Super useful - you don't have to remember where you left off!
-- ================================================================================================
vim.api.nvim_create_autocmd("BufReadPost", {
  group = vim.api.nvim_create_augroup("user/last_location", { clear = true }),
  desc = "Go to last cursor position when opening a file",
  callback = function(args)
    -- Get the mark `"` which stores the last cursor position
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(args.buf)

    -- Only jump if the mark is valid (within file bounds)
    if mark[1] > 0 and mark[1] <= line_count then
      -- g`" = go to mark, zz = center the screen
      vim.cmd('normal! g`"zz')
    end
  end,
})

-- ================================================================================================
-- CLOSE WITH q
-- In certain windows (help, quickfix, etc.), press 'q' to close instead of :q
-- Much more convenient for read-only/temporary windows.
-- ================================================================================================
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("user/close_with_q", { clear = true }),
  desc = "Press q to close help, quickfix, man pages, etc.",
  -- These are the file types where 'q' will close the window
  pattern = {
    "help",        -- :help windows
    "qf",          -- quickfix list (:copen)
    "man",         -- man pages
    "git",         -- git commit messages, etc.
    "lspinfo",     -- :LspInfo window
    "checkhealth", -- :checkhealth window
  },
  callback = function(args)
    -- Set buffer-local keymap: q = close window
    vim.keymap.set("n", "q", "<cmd>close<cr>", {
      buffer = args.buf,
      silent = true,
      desc = "Close window",
    })
  end,
})

-- ================================================================================================
-- RELATIVE LINE NUMBERS - SMART TOGGLE
-- Show relative numbers in Normal mode (useful for jumping: 5j, 10k)
-- Show absolute numbers in Insert mode (useful for knowing actual line number)
-- ================================================================================================
local line_numbers_group = vim.api.nvim_create_augroup("user/smart_line_numbers", { clear = true })

-- Turn ON relative numbers when entering normal mode / focusing window
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
  group = line_numbers_group,
  desc = "Enable relative line numbers in normal mode",
  callback = function()
    -- Only if line numbers are enabled for this window
    if vim.wo.number then
      vim.wo.relativenumber = true
    end
  end,
})

-- Turn OFF relative numbers when entering insert mode / leaving window
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
  group = line_numbers_group,
  desc = "Disable relative line numbers in insert mode",
  callback = function()
    if vim.wo.number then
      vim.wo.relativenumber = false
    end
  end,
})

-- ================================================================================================
-- AUTO-RESIZE SPLITS
-- When you resize your terminal window, automatically resize all Neovim splits equally.
-- ================================================================================================
vim.api.nvim_create_autocmd("VimResized", {
  group = vim.api.nvim_create_augroup("user/resize_splits", { clear = true }),
  desc = "Auto-resize splits when terminal is resized",
  callback = function()
    -- Make all windows equal size
    vim.cmd("wincmd =")
  end,
})

-- ================================================================================================
-- REMOVE TRAILING WHITESPACE ON SAVE
-- Automatically removes trailing spaces at end of lines when you save.
-- ================================================================================================
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("user/trim_whitespace", { clear = true }),
  desc = "Remove trailing whitespace on save",
  callback = function()
    -- Save cursor position
    local cursor = vim.api.nvim_win_get_cursor(0)
    -- Remove trailing whitespace
    vim.cmd([[%s/\s\+$//e]])
    -- Restore cursor position
    vim.api.nvim_win_set_cursor(0, cursor)
  end,
})

-- ================================================================================================
-- CHECK IF FILE CHANGED OUTSIDE NEOVIM
-- When you focus Neovim again, check if the file was modified externally.
-- If so, reload it automatically.
-- ================================================================================================
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = vim.api.nvim_create_augroup("user/checktime", { clear = true }),
  desc = "Check if file was changed outside Neovim",
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})
