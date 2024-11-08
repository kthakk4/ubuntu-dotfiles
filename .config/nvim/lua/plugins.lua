-- Bootstrap Paq if it's not installed
local function clone_paq()
  local path = vim.fn.stdpath("data") .. "/site/pack/paqs/start/paq-nvim"
  local is_installed = vim.fn.empty(vim.fn.glob(path)) == 0
  if not is_installed then
    vim.fn.system { "git", "clone", "--depth=1", "https://github.com/savq/paq-nvim.git", path }
    return true
  end
end

-- Install packages and run package set up
local function bootstrap_paq(packages)
  local first_install = clone_paq()
  vim.cmd.packadd("paq-nvim")
  local paq = require("paq")

  if first_install then
    vim.notify("Installing plugins... If prompted, hit Enter to continue.")
  end

  -- Read and install packages
  paq(packages)
  paq.install()

  end

-- Call helper function
bootstrap_paq {
  "savq/paq-nvim",
  'rebelot/kanagawa.nvim',
  { "catppuccin/nvim", as = "catppuccin" },
 {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},
 'ibhagwan/fzf-lua',
 'echasnovski/mini.statusline',
 'echasnovski/mini.icons'
}

-- Set up packages
require'nvim-treesitter.configs'.setup {
 -- a list of parser names, or "all" (the listed parsers MUST always be installed)
 ensure_installed = {'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc', 'python'},

 -- Install parsers synchronously (only applied to `ensure_installed`)
 sync_install = false,

 -- Automatically install missing parsers when entering buffer
 -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
 auto_nstall = true,

 highlight = {
   enable = true,

   -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
   -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
   -- the name of the parser)
   -- list of language that will be disabled
   disable = { "c", "rust" },

   -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
   -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
   -- Using this option may slow down your editor, and you may see some duplicate highlights.
   -- Instead of true it can also be a list of languages
   additional_vim_regex_highlighting = false,
 },
}

require('mini.statusline').setup()
require('mini.icons').setup()
require("catppuccin").setup({
    flavour = "auto", -- latte, frappe, macchiato, mocha
    background = { -- :h background
        light = "latte",
        dark = "mocha",
    },
    transparent_background = true, -- disables setting the background color.
    term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
})

