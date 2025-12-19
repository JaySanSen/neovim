-- ================================================================================================
-- TITLE : Treesitter
-- LINKS :
--   > github : https://github.com/nvim-treesitter/nvim-treesitter
-- ABOUT : Provides better syntax highlighting, code folding, and indentation using tree-sitter
--         parsers. Tree-sitter parses code into a syntax tree for accurate understanding.
-- REQUIRES : Neovim 0.11+, tree-sitter-cli, C compiler
-- ================================================================================================

return {
  "nvim-treesitter/nvim-treesitter",

  -- Don't lazy load - treesitter needs to be available immediately
  lazy = false,

  -- Run :TSUpdate after install/update to compile parsers
  build = ":TSUpdate",

  config = function()
    -- ==========================================================================================
    -- SETUP
    -- Basic configuration - install_dir is where parsers are stored
    -- ==========================================================================================
    require("nvim-treesitter").setup({
      install_dir = vim.fn.stdpath("data") .. "/site",
    })

    -- ==========================================================================================
    -- PARSER INSTALLATION
    -- List of parsers to install. Only installs if not already present.
    -- Run :TSInstall <language> to add more, or add to this list.
    -- ==========================================================================================
    local parsers = {
      "bash",
      "c",
      "cpp",
      "css",
      "go",
      "html",
      "java",
      "javascript",
      "json",
      "lua",
      "markdown",
      "markdown_inline",
      "python",
      "rust",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "yaml",
      "zig",
    }


    local function is_installed(lang)
      local ok = pcall(vim.treesitter.language.add, lang)
      return ok
    end



    -- Check which parsers are missing and only install those
    local to_install = {}

    for _, parser in ipairs(parsers) do
      if not is_installed(parser) then
        table.insert(to_install, parser)
      end
    end

    -- Only run install if there are missing parsers (avoids the message spam)
    if #to_install > 0 then
      require("nvim-treesitter").install(to_install)
    end

    -- ==========================================================================================
    -- HIGHLIGHTING
    -- Enable treesitter-based syntax highlighting for all supported filetypes.
    -- This replaces Vim's regex-based highlighting with accurate syntax tree highlighting.
    -- ==========================================================================================
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("user/treesitter_highlight", { clear = true }),
      desc = "Enable treesitter highlighting",
      callback = function(args)
        -- Only enable if a parser exists for this filetype
        local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
        if lang and pcall(vim.treesitter.start, args.buf, lang) then
          -- Successfully started treesitter for this buffer
        end
      end,
    })

    -- ==========================================================================================
    -- FOLDING (Optional)
    -- Use treesitter for code folding instead of indent-based folding.
    -- Uncomment if you want treesitter-based folds.
    -- ==========================================================================================
     vim.api.nvim_create_autocmd("FileType", {
       group = vim.api.nvim_create_augroup("user/treesitter_fold", { clear = true }),
       desc = "Enable treesitter folding",
       callback = function(args)
         local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
         if lang and pcall(vim.treesitter.language.inspect, lang) then
           vim.wo[0][0].foldmethod = "expr"
           vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
         end
       end,
     })

     -- ==========================================================================================
     -- INDENTATION (Experimental)
     -- Use treesitter for auto-indentation. This is experimental and may not work perfectly.
     -- Uncomment if you want to try it.
     -- ==========================================================================================
     -- vim.api.nvim_create_autocmd("FileType", {
       --   group = vim.api.nvim_create_augroup("user/treesitter_indent", { clear = true }),
       --   desc = "Enable treesitter indentation",
       --   callback = function(args)
         --     local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
         --     if lang and pcall(vim.treesitter.language.inspect, lang) then
         --       vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
         --     end
         --   end,
         -- })
       end,
     }

