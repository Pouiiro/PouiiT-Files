return {
  'nvimtools/none-ls.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvimtools/none-ls-extras.nvim',
  },
  config = function()
    local null_ls = require 'null-ls'

    null_ls.setup {
      sources = {
        require 'none-ls.code_actions.eslint_d', -- requires none-ls-extras.nvim
      },
      diagnostics_format = '#{m} (#{s})',
      update_in_insert = true,
    }
  end,
}
