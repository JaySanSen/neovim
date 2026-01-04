
return {
  {
    'nvim-mini/mini.clue',  -- Plugin name
    config = function()
      -- Place your configuration for mini.clue here
      require('mini.clue').setup({
        triggers = {
          -- Define your triggers here
          { mode = { 'n', 'x' }, keys = '<Leader>' },
          { mode = { 'n', 'x' }, keys = 'g' },
          { mode = 'n', keys = '<C-w>' },
          { mode = { 'n', 'x' }, keys = 'z' },
        },
        clues = {
          require('mini.clue').gen_clues.square_brackets(),
          require('mini.clue').gen_clues.g(),
          require('mini.clue').gen_clues.windows(),
          require('mini.clue').gen_clues.z(),
        },
        window = {
          delay = 1000,  -- Show the window after 1 second delay
          scroll_down = '<C-d>',
          scroll_up = '<C-u>',
          config = {
            width = 'auto',  -- Auto width based on content
            border = 'double',
          },
        },
      })
    end
  }
}
