return {
  'mistricky/codesnap.nvim',
  build = 'make',
  lazy = false,
  keys = {
    { '<leader>cs', '<cmd>CodeSnap<cr>', mode = 'x', desc = 'Save selected code snapshot into clipboard' },
    { '<leader>cf', '<cmd>CodeSnapSave<cr>', mode = 'x', desc = 'Save selected code snapshot in ~/Pictures' },
  },
  opts = {
    save_path = '~/Pictures',
    has_breadcrumbs = true,
    bg_theme = 'bamboo',
  },
}
