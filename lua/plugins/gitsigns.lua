return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    signs = {
      add          = { text = '┃' },
      change       = { text = '┃' },
      delete       = { text = '_' },
      topdelete    = { text = '‾' },
      changedelete = { text = '~' },
      untracked    = { text = '┆' },
    },
    signs_staged = {
      add          = { text = '┃' },
      change       = { text = '┃' },
      delete       = { text = '_' },
      topdelete    = { text = '‾' },
      changedelete = { text = '~' },
      untracked    = { text = '┆' },
    },
    signs_staged_enable = true,
    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
      delay = 200,
      --ignore_whitespace = false,
      --virt_text_priority = 100,
      --use_focus = true,
    },
    current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
    max_file_length = 40000, -- Disable if file is longer than this (in lines)
    preview_config = {
      -- Options passed to nvim_open_win
      border = "rounded",
      style = 'minimal',
      relative = 'cursor',
      row = 0,
      col = 1
    },

    on_attach = function(bufnr)
      local gitsigns = require('gitsigns')

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end


    -- Navigation between hunks
    map('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal({']c', bang = true})
      else
        gitsigns.nav_hunk('next')
      end
    end, { desc = "Next [C]hange" })

    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal({'[c', bang = true})
      else
        gitsigns.nav_hunk('prev')
      end
    end, { desc = "Next [C]hange" })

    -- Hunk Actions
    map('n', '<leader>hs', gitsigns.stage_hunk, { desc = "[H]unk [S]tage" })
    map('n', '<leader>hr', gitsigns.reset_hunk, { desc = "[H]unk [R]eset" })
    map('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = "[H]unk [U]ndo Stage" })
    map('n', '<leader>hp', gitsigns.preview_hunk, { desc = "[H]unk [P]review" })


    -- Visual mode: stage / reset selected lines
    map('v', '<leader>hs', function()
      gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end, { desc = "[H]unk [S]tage Selection" })

    map('v', '<leader>hr', function()
      gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end, { desc = "[H]unk [R]eset Selection" })


    map('n', '<leader>hS', gitsigns.stage_buffer, { desc = "[H]unk [S]tage buffer"})
    map('n', '<leader>hR', gitsigns.reset_buffer, { desc = "[H]unk [R]eset buffer"})
    -- map('n', '<leader>hp', gitsigns.preview_hunk, { desc = "[H]unk [S]tage buffer"})
    -- map('n', '<leader>hi', gitsigns.preview_hunk_inline, { desc = "[H]unk [S]tage buffer"})

    map('n', '<leader>hb', function()
      gitsigns.blame_line({ full = true })
    end, { desc = "[H]unk [B]lame Line"})

    -- map('n', '<leader>hB', gitsigns.blame, { desc = "[H]unk [B]lame Buffer"})

    map('n', '<leader>hd', gitsigns.diffthis, { desc = "[H]unk [D]iff"})

    map('n', '<leader>hD', function()
      gitsigns.diffthis('~')
    end, { desc = "[H]unk [D]iff ~"})

    -- map('n', '<leader>hQ', function() gitsigns.setqflist('all') end, { desc = ""})
    -- map('n', '<leader>hq', gitsigns.setqflist, { desc = ""})

    -- Toggles
    map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = "[T]oggle [B]lame Line"})
    map('n', '<leader>tw', gitsigns.toggle_word_diff, { desc = "[T]oggle [W]ord Diff"})
    map('n', '<leader>td', gitsigns.toggle_deleted, { desc = "[T]oggle [D]eleted"})

    -- Text object
    map({'o', 'x'}, 'ih', gitsigns.select_hunk, { desc = "[S]elect [I]nner Hunk"})

  end
},

}
