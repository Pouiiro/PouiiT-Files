return {
  'romgrk/barbar.nvim',
  event = 'VeryLazy',
  enabled = false,
  dependencies = {
    'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
    'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
  },
  init = function()
    vim.g.barbar_auto_setup = false
  end,
  opts = {
    -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
    animation = true,
    insert_at_end = true,
    no_name_title = 'Untitled',
    sidebar_filetypes = {
      -- Use the default values: {event = 'BufWinLeave', text = '', align = 'left'}
      NvimTree = true,
      -- Or, specify the text used for the offset:
    },
    -- …etc.
  },
  version = '^1.0.0', -- optional: only update when a new 1.x version is released
}
