return {
  { 'nvzone/volt', lazy = true },
  { 'nvzone/menu', lazy = true },
  {
    'nvzone/minty',
    cmd = { 'Shades', 'Huefy' },
  },
  {
    'nvzone/showkeys',
    cmd = 'ShowkeysToggle',
    laze = false,
    opts = {
      timeout = 1,
      maxkeys = 5,
      winopts = {
        focusable = false,
        relative = 'editor',
        style = 'minimal',
        border = 'rounded',
        height = 1,
        row = 1,
        col = 0,
        zindex = 100,
      },
      winhl = 'FloatBorder:Comment,Normal:Normal',
    },
  },
  {
    'rachartier/tiny-glimmer.nvim',
    event = 'VeryLazy',
    priority = 10, -- Needs to be a really low priority, to catch others plugins keybindings.
    opts = {
      -- your configuration
    },
  },
}
