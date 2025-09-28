-- tailwind-tools.lua
return {
  'luckasRanarison/tailwind-tools.nvim',
  name = 'tailwind-tools',
  build = ':UpdateRemotePlugins',
  enabled = require('utils.tailwind').has_tailwind(),
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-telescope/telescope.nvim', -- optional
    'neovim/nvim-lspconfig', -- optional
  },
  opts = {
    extension = {
      queries = {}, -- a list of filetypes having custom `class` queries
      patterns = { -- a map of filetypes to Lua pattern lists
        -- rust = { "class=[\"']([^\"']+)[\"']" },
        javascript = { 'clsx%(([^)]+)%)' },
      },
    },
    keymaps = {
      smart_increment = { -- increment tailwindcss units using <C-a> and <C-x>
        enabled = false,
      },
    },
  },
}
