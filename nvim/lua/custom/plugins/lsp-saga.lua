return {
  'nvimdev/lspsaga.nvim',
  config = function()
    local keymap = vim.keymap

    require('lspsaga').setup {
      hover = {
        max_width = 2.0,
        max_height = 2.0,
      },
      symbol_in_winbar = {
        enable = false,
      },
      diagnostic = {
        on_insert = false,
      },
      code_action = {
        show_server_name = true,
      },
      ui = {
        title = true,
        border = 'rounded',
        winblend = 0,
        theme = 'round',
        expand = '',
        collapse = '',
        preview = ' ',
        code_action = '💡',
        diagnostic = '🐞',
        incoming = ' ',
        outgoing = ' ',
      },
      preview = {
        lines_above = 0,
        lines_below = 20,
      },
      lightbulb = {
        enable = false,
        enable_in_insert = true,
        sign = true,
        sign_priority = 40,
        virtual_text = true,
      },
    }

    keymap.set({ 'n', 't' }, '<C-->', '<cmd>Lspsaga term_toggle<cr>')
  end,
  dependencies = {
    'nvim-treesitter/nvim-treesitter', -- optional
    'nvim-tree/nvim-web-devicons', -- optional
  },
}
