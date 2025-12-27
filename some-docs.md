# Complete Neovim/LazyVim Configuration Guide

A comprehensive reference for configuring Neovim with Lazy.nvim plugin manager. Perfect for beginners and intermediate users.

## Table of Contents
1. [Configuration Structure](#configuration-structure)
2. [Plugin Configuration Syntax](#plugin-configuration-syntax)
3. [Loading Strategies](#loading-strategies)
4. [Configuration Methods](#configuration-methods)
5. [Keymaps](#keymaps)
6. [Variables](#variables)
7. [Functions](#functions)
8. [Autocommands (Hooks)](#autocommands-hooks)
9. [Event Order & Custom Events](#event-order--custom-events)
10. [Practical Examples](#practical-examples)

---

## Configuration Structure

```
~/.config/nvim/
├── init.lua                    # Entry point - loads everything
├── lua/
│   ├── config/
│   │   ├── options.lua        # Vim options (set commands)
│   │   ├── keymaps.lua        # Global keybindings
│   │   ├── autocmds.lua       # Auto commands
│   │   └── lazy.lua           # Lazy.nvim plugin manager setup
│   └── plugins/
│       ├── neotree.lua        # Plugin-specific configs
│       ├── telescope.lua
│       └── subfolder/
│           └── plugin.lua     # Organized in subfolders
└── after/
    └── plugin/
        └── keymaps.lua        # Plugin-specific keymaps (loads after plugins)
```

### Basic init.lua

```lua
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load config files
require("config.options")   -- Vim options
require("config.keymaps")   -- Global keymaps
require("config.lazy")      -- Plugin manager setup
```

### Lazy.nvim Setup (lua/config/lazy.lua)

```lua
require("lazy").setup({
  spec = {
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    { import = "plugins" },
    -- Import subfolders
    { import = "plugins.ui" },
    { import = "plugins.editor" },
    { import = "plugins.coding" },
  },
  defaults = {
    lazy = false,
    version = false,
  },
  checker = { enabled = true },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
```

---

## Plugin Configuration Syntax

### Complete Plugin Spec Structure

```lua
return {
  "author/plugin-name",           -- Required: GitHub repo

  -- When to load
  lazy = false,                   -- Load immediately (default: true)
  event = "VeryLazy",            -- Load on event
  ft = "lua",                    -- Load on filetype
  cmd = "CommandName",           -- Load on command
  keys = { ... },                -- Load on keypress

  -- Version/Branch
  version = "1.0.0",             -- Use specific version
  branch = "main",               -- Use specific branch
  tag = "v2.*",                  -- Use tag pattern
  commit = "abc123",             -- Use specific commit

  -- Build/Dependencies
  build = "make",                -- Run after install/update
  dependencies = { "other/plugin" },  -- Required plugins

  -- Configuration
  opts = { ... },                -- Passed to require("plugin").setup(opts)
  config = function() ... end,   -- Custom setup function
  init = function() ... end,     -- Runs before plugin loads

  -- Conditionals
  enabled = true,                -- Enable/disable plugin
  cond = function() return true end,  -- Load conditionally
}
```

### Real-World Example

```lua
return {
  "nvim-neo-tree/neo-tree.nvim",

  -- Loading
  cmd = "Neotree",
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle Explorer" },
  },

  -- Dependencies
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },

  -- Configuration
  opts = {
    filesystem = {
      follow_current_file = {
        enabled = true,
      },
      filtered_items = {
        hide_dotfiles = false,
      },
    },
    window = {
      width = 30,
      mappings = {
        ["<space>"] = "none",
      },
    },
  },

  -- Additional setup
  config = function(_, opts)
    require("neo-tree").setup(opts)

    -- Custom autocommand
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "neo-tree",
      callback = function()
        vim.opt_local.number = false
      end,
    })
  end,
}
```

---

## Loading Strategies

### 1. Event-based Loading (Most Common)

```lua
return {
  "plugin/name",
  event = "VeryLazy",           -- After startup
  -- OR
  event = { "BufReadPre", "BufNewFile" },  -- On buffer open
  -- OR
  event = "InsertEnter",        -- Entering insert mode
  -- OR
  event = "LspAttach",          -- When LSP attaches
}
```

**Common events:**
- `"VeryLazy"` - After startup
- `"BufReadPost"` - After opening a file
- `"InsertEnter"` - Entering insert mode
- `"CmdlineEnter"` - Opening command line
- `"LspAttach"` - LSP attaches to buffer

### 2. Filetype Loading

```lua
return {
  "plugin/name",
  ft = "python",               -- Single filetype
  -- OR
  ft = { "python", "lua" },    -- Multiple filetypes
}
```

### 3. Command Loading

```lua
return {
  "plugin/name",
  cmd = "CommandName",         -- Single command
  -- OR
  cmd = { "Cmd1", "Cmd2" },    -- Multiple commands
}
```

### 4. Keymap Loading

```lua
return {
  "plugin/name",
  keys = {
    { "<leader>f", "<cmd>SomeCommand<cr>", desc = "Description" },
    { "<leader>g", function() require("plugin").method() end, mode = "n" },
  },
}
```

---

## Configuration Methods

### Method 1: opts (Simple - Auto calls setup)

```lua
return {
  "plugin/name",
  opts = {
    option1 = true,
    option2 = "value",
    nested = {
      key = "value",
    },
  },
}
```

**Equivalent to:**
```lua
require("plugin-name").setup({
  option1 = true,
  option2 = "value",
})
```

### Method 2: config (Full Control)

```lua
return {
  "plugin/name",
  config = function()
    require("plugin-name").setup({
      option1 = true,
    })

    -- Additional setup
    vim.api.nvim_set_keymap("n", "<leader>x", ":Command<CR>", {})
  end,
}
```

### Method 3: init (Before Plugin Loads)

```lua
return {
  "plugin/name",
  init = function()
    -- Set vim globals before plugin loads
    vim.g.plugin_option = true
    vim.g.plugin_config = { key = "value" }
  end,
}
```

### Merging with LazyVim Defaults

```lua
return {
  "plugin/already-in-lazyvim",

  -- This ADDS to existing opts
  opts = {
    new_option = true,
  },

  -- This REPLACES existing opts
  opts = function(_, opts)
    opts.new_option = true
    opts.existing_option = "changed"
    return opts
  end,
}
```

---

## Keymaps

### Keymap Definition in Plugins

```lua
keys = {
  -- Basic format
  { "lhs", "rhs", desc = "Description" },

  -- With mode
  { "lhs", "rhs", mode = "n", desc = "Normal mode" },
  { "lhs", "rhs", mode = { "n", "v" }, desc = "Normal and Visual" },

  -- With function
  { "lhs", function() print("hello") end, desc = "Run function" },

  -- With options
  { "lhs", "rhs", silent = true, noremap = true, desc = "Silent" },

  -- Disable default keymap
  { "<leader>e", false },  -- Disables this key
}
```

### Global Keymaps (lua/config/keymaps.lua)

```lua
-- Set leader key (must be before lazy setup)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- General keybindings
local map = vim.keymap.set

-- Better window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Resize windows
map("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- Better indenting
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Move text up and down
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move text down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move text up" })

-- Clear search highlight
map("n", "<Esc>", ":noh<CR>", { desc = "Clear search highlight" })

-- Save file
map("n", "<C-s>", ":w<CR>", { desc = "Save file" })
map("i", "<C-s>", "<Esc>:w<CR>a", { desc = "Save file" })
```

### Keymap Syntax Reference

```lua
vim.keymap.set(mode, lhs, rhs, opts)
```

- **mode**: `"n"` (normal), `"i"` (insert), `"v"` (visual), `"x"` (visual block), `"t"` (terminal)
- **lhs**: The key you press (left-hand side)
- **rhs**: What it does (right-hand side)
- **opts**: Options table

**Common options:**
```lua
{
  desc = "Description",  -- Shows in which-key
  silent = true,         -- Don't show command in command line
  noremap = true,        -- Don't use recursive mapping (default true)
  buffer = 0,            -- Only for current buffer
  nowait = true,         -- Execute immediately
  expr = true,           -- Expression mapping
}
```

### Recommended Keymap Organization

```lua
-- <leader>f - Find (telescope/fzf)
-- <leader>g - Git
-- <leader>t - Test/Terminal
-- <leader>d - Debug
-- <leader>c - Code actions
-- <leader>w - Window/workspace
-- <leader>b - Buffers
-- <leader>s - Search/Session
-- <leader>x - Diagnostics/Trouble
```

---

## Variables

### 1. Local Variables (File scope)
```lua
-- Only visible in current file
local my_var = "value"
local config = {
  option1 = true,
  option2 = "test",
}

-- Use them
print(my_var)
config.option1 = false
```

### 2. Vim Global Variables
```lua
-- Accessible as g:variable_name in vimscript
vim.g.my_global = "value"
vim.g.mapleader = " "
vim.g.plugin_enabled = true

-- Access
print(vim.g.my_global)
```

### 3. Buffer/Window/Tabpage Local Variables
```lua
-- Buffer-local (b:variable)
vim.b.my_buffer_var = "only in this buffer"

-- Window-local (w:variable)
vim.w.my_window_var = "only in this window"

-- Tabpage-local (t:variable)
vim.t.my_tab_var = "only in this tab"

-- Access from current buffer/window/tab
print(vim.b.my_buffer_var)

-- Access specific buffer (buffer number 1)
print(vim.b[1].my_buffer_var)
```

### 4. Environment Variables
```lua
-- Read
local home = vim.env.HOME
local term = vim.env.TERM

-- Set
vim.env.MY_VAR = "value"
```

### 5. Vim Options
```lua
-- Global options
vim.opt.number = true              -- set number
vim.opt.relativenumber = true      -- set relativenumber
vim.opt.tabstop = 2                -- set tabstop=2
vim.opt.shiftwidth = 2             -- set shiftwidth=2
vim.opt.expandtab = true           -- set expandtab

-- Buffer-local options
vim.bo.filetype = "lua"            -- setlocal filetype=lua

-- Window-local options
vim.wo.number = true               -- setlocal number
```

---

## Functions

### 1. Local Functions (File scope)
```lua
-- Define
local function greet(name)
  return "Hello, " .. name
end

-- Or
local greet = function(name)
  return "Hello, " .. name
end

-- Use
local message = greet("World")
print(message)
```

### 2. Module Functions (Shareable between files)
```lua
-- File: ~/.config/nvim/lua/mymodule.lua
local M = {}

M.greet = function(name)
  return "Hello, " .. name
end

M.config = {
  option1 = true,
}

return M

-- Use from another file:
local mymodule = require("mymodule")
print(mymodule.greet("World"))
print(mymodule.config.option1)
```

### 3. Utility Module Example
```lua
-- File: ~/.config/nvim/lua/utils/init.lua
local M = {}

M.get_visual_selection = function()
  local _, ls, cs = unpack(vim.fn.getpos("'<"))
  local _, le, ce = unpack(vim.fn.getpos("'>"))
  return vim.api.nvim_buf_get_text(0, ls-1, cs-1, le-1, ce, {})
end

M.buf_kill = function(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_delete(bufnr, { force = false })
end

return M

-- Use anywhere:
local utils = require("utils")
local selection = utils.get_visual_selection()
```

### 4. Plugin Helper Functions Pattern
```lua
return {
  "plugin/name",
  config = function()
    local setup_keymaps = function()
      vim.keymap.set("n", "<leader>x", ":Cmd<CR>")
    end

    local setup_autocmds = function()
      vim.api.nvim_create_autocmd("BufEnter", {
        callback = function()
          print("Buffer entered")
        end,
      })
    end

    require("plugin").setup({})
    setup_keymaps()
    setup_autocmds()
  end,
}
```

---

## Autocommands (Hooks)

### 1. Basic Autocommand
```lua
vim.api.nvim_create_autocmd("EventName", {
  pattern = "*.lua",           -- File pattern
  callback = function(args)    -- What to do
    print("Event fired!")
    print(args.file)           -- Access event data
  end,
})
```

### 2. Autocommand with Group
```lua
-- Create group (for organization and easy clearing)
local augroup = vim.api.nvim_create_augroup("MyGroup", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  pattern = "*.lua",
  callback = function()
    vim.lsp.buf.format()
  end,
  desc = "Format Lua files on save",
})
```

### 3. Multiple Events
```lua
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = "*.md",
  callback = function()
    vim.opt_local.wrap = true
  end,
})
```

### 4. Access Event Data
```lua
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function(args)
    print("Buffer:", args.buf)      -- Buffer number
    print("File:", args.file)       -- File name
    print("Match:", args.match)     -- Matched pattern
    print("Event:", args.event)     -- Event name
    print("Group:", args.group)     -- Augroup ID
  end,
})
```

### 5. One-time Autocommand
```lua
vim.api.nvim_create_autocmd("VimEnter", {
  once = true,  -- Only fires once
  callback = function()
    print("Neovim started!")
  end,
})
```

### 6. Buffer-specific Autocommand
```lua
vim.api.nvim_create_autocmd("BufWritePre", {
  buffer = 0,  -- 0 = current buffer, or use buffer number
  callback = function()
    print("Saving current buffer")
  end,
})
```

---

## Event Order & Custom Events

### Neovim Startup Event Order

```
1. VimEnter           → After reading vimrc, before loading files
2. BufNew             → Creating new buffer
3. BufReadPre         → Before reading file into buffer
4. BufRead            → After reading file into buffer
5. BufReadPost        → After reading file (modelines processed)
6. FileType           → After filetype detected
7. BufWinEnter        → After buffer shown in window
8. VeryLazy           → LazyVim custom - after full startup
```

### Complete Event Reference

#### Buffer Events
```lua
"BufAdd"          -- After buffer added to buffer list
"BufNew"          -- After creating new buffer
"BufNewFile"      -- Starting to edit new file
"BufReadPre"      -- Before reading file into buffer
"BufRead"         -- After reading file into buffer
"BufReadPost"     -- After reading file (after modelines)
"BufEnter"        -- After entering buffer
"BufLeave"        -- Before leaving buffer
"BufWinEnter"     -- After buffer shown in window
"BufWinLeave"     -- Before buffer removed from window
"BufUnload"       -- Before unloading buffer
"BufDelete"       -- Before deleting buffer
"BufWipeout"      -- Before wiping out buffer
"BufWritePre"     -- Before writing buffer to file
"BufWritePost"    -- After writing buffer
```

#### Window Events
```lua
"WinNew"          -- After creating window
"WinEnter"        -- After entering window
"WinLeave"        -- Before leaving window
"WinClosed"       -- After closing window
"WinResized"      -- After window resized
```

#### File Events
```lua
"FileType"        -- When filetype set
"FileChangedShell" -- File changed outside Vim
"FileReadPre"     -- Before reading file
"FileReadPost"    -- After reading file
"FileWritePre"    -- Before writing file
"FileWritePost"   -- After writing file
```

#### Insert Mode Events
```lua
"InsertEnter"     -- Starting insert mode
"InsertChange"    -- When typing in insert mode
"InsertLeave"     -- Leaving insert mode
"InsertCharPre"   -- Before inserting character
```

#### Command Events
```lua
"CmdlineEnter"    -- After entering command line
"CmdlineLeave"    -- Before leaving command line
"CmdwinEnter"     -- After entering command window
"CmdwinLeave"     -- Before leaving command window
```

#### LSP Events
```lua
"LspAttach"       -- After LSP attaches to buffer
"LspDetach"       -- After LSP detaches from buffer
"LspProgress"     -- LSP progress update
```

#### UI Events
```lua
"VimEnter"        -- After doing all startup
"VimLeavePre"     -- Before exiting Vim
"VimLeave"        -- Before exiting Vim (after VimLeavePre)
"VimResized"      -- After Vim window resized
"FocusGained"     -- Vim got focus
"FocusLost"       -- Vim lost focus
"ColorScheme"     -- After loading colorscheme
"TabEnter"        -- After entering tab page
"TabLeave"        -- Before leaving tab page
```

#### Text Change Events
```lua
"TextChanged"     -- After text changed in normal mode
"TextChangedI"    -- After text changed in insert mode
"TextYankPost"    -- After yanking text
```

### Custom User Events

#### Create Custom Event
```lua
-- Fire custom event
vim.api.nvim_exec_autocmds("User", {
  pattern = "MyCustomEvent",
  data = { message = "Hello!" },
})
```

#### Listen to Custom Event
```lua
vim.api.nvim_create_autocmd("User", {
  pattern = "MyCustomEvent",
  callback = function(args)
    print("Custom event fired!")
    print(args.data.message)  -- Access custom data
  end,
})
```

#### Plugin Event System Example
```lua
-- Create module with event system
local M = {}
local events = {}

-- Register event listener
M.on = function(event_name, callback)
  if not events[event_name] then
    events[event_name] = {}
  end
  table.insert(events[event_name], callback)
end

-- Trigger event
M.emit = function(event_name, data)
  if events[event_name] then
    for _, callback in ipairs(events[event_name]) do
      callback(data)
    end
  end
end

-- Usage:
M.on("file_saved", function(data)
  print("File saved:", data.filename)
end)

M.emit("file_saved", { filename = "test.lua" })

return M
```

---

## Practical Examples

### Example 1: Auto-format on Save
```lua
local format_on_save = vim.api.nvim_create_augroup("FormatOnSave", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
  group = format_on_save,
  pattern = { "*.lua", "*.js", "*.ts", "*.py" },
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
  desc = "Format file on save",
})
```

### Example 2: Highlight Yanked Text
```lua
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({
      higroup = "Visual",
      timeout = 200,
    })
  end,
  desc = "Highlight yanked text",
})
```

### Example 3: Auto-create Directories on Save
```lua
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function(args)
    local dir = vim.fn.fnamemodify(args.file, ":p:h")
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, "p")
    end
  end,
  desc = "Auto-create directories when saving",
})
```

### Example 4: Restore Cursor Position
```lua
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
  desc = "Restore cursor position",
})
```

### Example 5: Close Certain Windows with 'q'
```lua
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "help", "qf", "man", "lspinfo", "startuptime" },
  callback = function(args)
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = args.buf })
  end,
  desc = "Close with q",
})
```

### Example 6: Disable Auto-commenting
```lua
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
  desc = "Disable auto-commenting",
})
```

### Example 7: Terminal Mode Settings
```lua
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
    vim.cmd("startinsert")
  end,
  desc = "Terminal settings",
})
```

### Example 8: Check for External File Changes
```lua
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
  desc = "Check for external file changes",
})
```

### Example 9: Resize Splits on Window Resize
```lua
vim.api.nvim_create_autocmd("VimResized", {
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
  desc = "Resize splits on window resize",
})
```

### Example 10: Per-Project Configuration
```lua
-- File: ~/.config/nvim/lua/config/autocmds.lua
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    local project_config = vim.fn.findfile(".nvim.lua", ".;")
    if project_config ~= "" then
      dofile(project_config)
    end
  end,
  desc = "Load project-local config",
})
```

---

## Dependencies

### Simple Dependencies
```lua
return {
  "main/plugin",
  dependencies = {
    "dep1/plugin",              -- Simple dependency
  },
}
```

### Configured Dependencies
```lua
return {
  "main/plugin",
  dependencies = {
    {
      "dep/plugin",
      opts = { option = true },
    },
  },
}
```

### Nested Dependencies
```lua
return {
  "main/plugin",
  dependencies = {
    {
      "dep1/plugin",
      dependencies = {
        "dep2/plugin",
      },
    },
  },
}
```

---

## Conditional Loading

### Enable/Disable Plugin
```lua
return {
  "plugin/name",
  enabled = false,  -- Disable plugin
}
```

### Conditional Loading
```lua
return {
  "plugin/name",

  -- Only if executable exists
  cond = function()
    return vim.fn.executable("git") == 1
  end,

  -- OR check environment
  cond = function()
    return vim.env.TERM == "xterm-kitty"
  end,

  -- OR check OS
  cond = function()
    return vim.loop.os_uname().sysname == "Linux"
  end,
}
```

---

## Build Commands

```lua
return {
  "plugin/name",

  build = "make",                          -- Shell command
  -- OR
  build = ":TSUpdate",                     -- Vim command
  -- OR
  build = function()                       -- Lua function
    vim.cmd("!make install")
  end,
}
```

---

## Tips & Best Practices

1. **Use lazy loading**: Load plugins only when needed with `event`, `ft`, `cmd`, or `keys`
2. **Organize with groups**: Use autocommand groups to organize related autocmds
3. **Use local variables**: Keep variables scoped to avoid polluting global namespace
4. **Descriptive names**: Add `desc` to keymaps for which-key integration
5. **Module pattern**: Create reusable modules in `lua/utils/` or `lua/lib/`
6. **Check before use**: Use `pcall()` to safely call functions that might fail
7. **Document your config**: Add comments explaining non-obvious configurations
8. **Use subfolders**: Organize plugins into subfolders (ui, editor, coding, etc.)
9. **Test changes**: Use `:Lazy reload plugin-name` to test plugin changes
10. **Check health**: Run `:checkhealth` to diagnose issues

---

## Useful Commands

```vim
:Lazy                    " Open Lazy plugin manager
:Lazy sync               " Install/update plugins
:Lazy clean              " Remove unused plugins
:Lazy reload plugin-name " Reload a plugin
:checkhealth             " Check Neovim health
:Telescope keymaps       " View all keymaps
:messages                " View messages
:verbose map <key>       " Check what maps to a key
:set option?             " Check option value
```

---

## Resources

- [Neovim Docs](https://neovim.io/doc/)
- [Lazy.nvim](https://github.com/folke/lazy.nvim)
- [LazyVim](https://www.lazyvim.org/)
- [Neovim Lua Guide](https://neovim.io/doc/user/lua-guide.html)
- [Neovim API](https://neovim.io/doc/user/api.html)

---

**Contributing**:
