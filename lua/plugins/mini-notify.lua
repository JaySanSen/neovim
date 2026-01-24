return
{
  'nvim-mini/mini.notify',
  version = '*',
  lazy = false,
  config = function()
    require('mini.notify').setup()
  end
}
