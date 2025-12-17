-- Set my colorscheme.
vim.cmd.colorscheme 'dracula'
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)



---@type LazySpec
local plugins = 'plugins'


require 'settings'
require 'keymaps'


require('lazy').setup(plugins, {
    ui = { border = 'rounded' },
    install = {
        -- Do not automatically install on startup.
        -- If setting to false make sure to run :Lazy when needed
        missing = false,
    },
    -- The popup saying change detected is disabled
    change_detection = { notify = false },
    -- None of my plugins use luarocks so disable this.
    rocks = {
        enabled = false,
    },
    performance = {
        rtp = {
            -- Stuff I don't use.
            disabled_plugins = {
                'gzip',
                'netrwPlugin',
                'rplugin',
                'tarPlugin',
                'tohtml',
                'tutor',
                'zipPlugin',
            },
        },
    },
})


-- vim.g.mapleader = " "
-- vim.g.maplocalleader= " "
