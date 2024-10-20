return {
  'lukas-reineke/indent-blankline.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  main = 'ibl',

  config = function()
    require('ibl').setup {
      indent = {
        char = '▎',
        tab_char = '▎', -- This was the fix
      },
    }
  end,
}
