return
{
  'nvim-mini/mini.tabline',
  version = '*',
  lazy = false,
  config = function()
    require('mini.tabline').setup()
  end
}
