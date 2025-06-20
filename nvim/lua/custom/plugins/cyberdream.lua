return {
  'scottmckendry/cyberdream.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('cyberdream').setup {
      transparent = true,
      italic_comments = true,
      -- borderless_pickers = true,
      ternimal_colors = true,
      cache = true,
      extensions = {
        lazy = true,
        cmp = true,
        treesitter = true,
        treesittercontext = true,
        fzflua = true,
        notify = true,
        noice = true,
        whichkey = true,
        gitsigns = true,
        dashboard = true,
        indentblankline = true,
        markdown = true,
        snacks = true,
      },
    }
    -- vim.cmd 'colorscheme cyberdream'
  end,
}
