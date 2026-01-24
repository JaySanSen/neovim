return
{
  'nvim-mini/mini.statusline',
  version = '*',
  lazy = false,
  config = function()
    require('mini.statusline').setup()
  end
}
