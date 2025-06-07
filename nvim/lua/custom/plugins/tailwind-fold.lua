return {
  'razak17/tailwind-fold.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  opts = {},
  enabled = require('utils.tailwind').has_tailwind(),
  ft = { 'html', 'svelte', 'astro', 'vue', 'typescriptreact', 'php', 'blade' },
}
