-- ================================================================================================
-- TITLE: NeoVim keymaps
-- ABOUT: Keymaps matching VS Code setup + Neovim quality-of-life
-- ================================================================================================

-- =============================================================================
-- GENERAL
-- =============================================================================
-- Escape from insert mode
vim.keymap.set("i", "jk", "<Esc>", { desc = "Return to normal mode" })

-- Center screen when jumping
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-- Better J behavior (keep cursor position when joining lines)
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })

-- Better indenting in visual mode (stay in visual mode)
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

-- =============================================================================
-- MOVE LINES (like VS Code alt+j/k)
-- =============================================================================
vim.keymap.set("n", "<A-j>", "<Cmd>m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", "<Cmd>m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
vim.keymap.set("i", "<A-j>", "<Esc><Cmd>m .+1<CR>==gi", { desc = "Move line down" })
vim.keymap.set("i", "<A-k>", "<Esc><Cmd>m .-2<CR>==gi", { desc = "Move line up" })

-- =============================================================================
-- WINDOW NAVIGATION (ctrl+h/j/k/l)
-- =============================================================================
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- =============================================================================
-- WINDOW SPLITTING (like VS Code space s v / space s d)
-- =============================================================================
vim.keymap.set("n", "<leader>sv", "<Cmd>vsplit<CR>", { desc = "[S]plit [V]ertical" })
vim.keymap.set("n", "<leader>sd", "<Cmd>split<CR>", { desc = "[S]plit [D]own (horizontal)" })
vim.keymap.set("n", "<leader>cs", "<Cmd>close<CR>", { desc = "[C]lose [S]plit" })

-- =============================================================================
-- WINDOW RESIZING (alt+i to increase, alt+d to decrease, or arrow keys)
-- =============================================================================
vim.keymap.set("n", "<A-i>", "<Cmd>resize +2<CR><Cmd>vertical resize +2<CR>", { desc = "Increase window size" })
vim.keymap.set("n", "<A-d>", "<Cmd>resize -2<CR><Cmd>vertical resize -2<CR>", { desc = "Decrease window size" })
vim.keymap.set("n", "<C-Up>", "<Cmd>resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", "<Cmd>resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", "<Cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", "<Cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-- =============================================================================
-- BUFFER/TAB NAVIGATION
-- =============================================================================
vim.keymap.set("n", "<leader>bn", "<Cmd>bnext<CR>", { desc = "[B]uffer [N]ext" })
vim.keymap.set("n", "<leader>bp", "<Cmd>bprevious<CR>", { desc = "[B]uffer [P]revious" })
vim.keymap.set("n", "<leader>ct", "<Cmd>bdelete<CR>", { desc = "[C]lose [T]ab/buffer" })

-- =============================================================================
-- LSP KEYMAPS (like VS Code space g h/d/r/i)
-- =============================================================================
vim.keymap.set("n", "<leader>gh", vim.lsp.buf.hover, { desc = "[G]lance [H]over" })
vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "[G]oto [D]efinition" })
vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, { desc = "[G]oto [R]eferences" })
vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, { desc = "[G]oto [I]mplementation" })
vim.keymap.set("n", "<leader>gt", vim.lsp.buf.type_definition, { desc = "[G]oto [T]ype definition" })
vim.keymap.set("n", "<leader>er", vim.lsp.buf.rename, { desc = "[E]lement [R]ename" })
vim.keymap.set("n", "<leader>fq", vim.lsp.buf.code_action, { desc = "[F]ix [Q]uick (code action)" })
vim.keymap.set("n", "<leader>fd", function() vim.lsp.buf.format({ async = true }) end, { desc = "[F]ormat [D]ocument" })

-- =============================================================================
-- DIAGNOSTICS (like VS Code space g p/n)
-- =============================================================================
vim.keymap.set("n", "<leader>gp", vim.diagnostic.goto_prev, { desc = "[G]oto [P]rev diagnostic" })
vim.keymap.set("n", "<leader>gn", vim.diagnostic.goto_next, { desc = "[G]oto [N]ext diagnostic" })
vim.keymap.set("n", "<leader>gl", vim.diagnostic.open_float, { desc = "[G]et [L]ine diagnostic" })

-- =============================================================================
-- NAVIGATION HISTORY (like VS Code space g b/f)
-- =============================================================================
vim.keymap.set("n", "<leader>gb", "<C-o>", { desc = "[G]o [B]ack" })
vim.keymap.set("n", "<leader>gf", "<C-i>", { desc = "[G]o [F]orward" })

-- =============================================================================
-- FOLDING (like VS Code space f c)
-- =============================================================================
vim.keymap.set("n", "<leader>fc", "za", { desc = "[F]old [C]ode toggle" })

-- =============================================================================
-- SEARCH / FIND (fzf-lua bindings - like VS Code space f f, space e s, etc.)
-- These require fzf-lua plugin to be installed
-- =============================================================================
vim.keymap.set("n", "<leader>ff", "<Cmd>FzfLua files<CR>", { desc = "[F]ind [F]iles" })
vim.keymap.set("n", "<leader>fg", "<Cmd>FzfLua live_grep<CR>", { desc = "[F]ind with [G]rep" })
vim.keymap.set("n", "<leader>fb", "<Cmd>FzfLua buffers<CR>", { desc = "[F]ind [B]uffers" })
vim.keymap.set("n", "<leader>fh", "<Cmd>FzfLua help_tags<CR>", { desc = "[F]ind [H]elp" })
vim.keymap.set("n", "<leader>fo", "<Cmd>FzfLua oldfiles<CR>", { desc = "[F]ind [O]ld/recent files" })
vim.keymap.set("n", "<leader>es", "<Cmd>FzfLua lsp_document_symbols<CR>", { desc = "[E]ditor [S]ymbols" })
vim.keymap.set("n", "<leader>ws", "<Cmd>FzfLua lsp_workspace_symbols<CR>", { desc = "[W]orkspace [S]ymbols" })
vim.keymap.set("n", "<leader>sc", "<Cmd>FzfLua commands<CR>", { desc = "[S]how [C]ommands" })

-- =============================================================================
-- TERMINAL (alt+t like VS Code)
-- =============================================================================
  vim.keymap.set("n", "<A-t>", function()
    require ("float_term").float_term()
  end, { desc = "Toggle floating terminal" })
  vim.keymap.set("t", "<A-t>", function()
    require ("float_term").float_term()
  end, { desc = "Toggle floating terminal" })


-- =============================================================================
-- GIT (alt+g like VS Code)
-- These require gitsigns or fugitive plugin
-- =============================================================================
vim.keymap.set("n", "<A-g>", "<Cmd>FzfLua git_status<CR>", { desc = "Git status" })

-- =============================================================================
-- FILE EXPLORER (Oil)
-- =============================================================================
vim.keymap.set("n", "-", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "<leader>nt", "<CMD>Oil --float<CR>", { desc = "[N]erd [T]ree style explorer" })

-- =============================================================================
-- MISC
-- =============================================================================
-- Quick config editing
vim.keymap.set("n", "<leader>rc", "<Cmd>e $MYVIMRC<CR>", { desc = "Edit config" })

-- Clear search highlighting
vim.keymap.set("n", "<Esc>", "<Cmd>nohlsearch<CR>", { desc = "Clear search highlight" })




vim.keymap.set("n", "<leader>lr", function()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  for _, client in ipairs(clients) do
    vim.lsp.stop_client(client.id)
  end

  vim.defer_fn(function()
    vim.cmd("edit")
  end, 100)
  vim.notify("LSP Restarting ... ", vim.log.levels.INFO)
end, { desc = "LSP Restart" })

