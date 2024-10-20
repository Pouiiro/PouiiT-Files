return {
  'luukvbaal/statuscol.nvim',
  config = function()
    local builtin = require 'statuscol.builtin'

    require('statuscol').setup {
      segments = {
        { text = { ' ', builtin.lnumfunc, ' ' }, click = 'v:lua.ScLa' },
        {
          text = { '  ', builtin.foldfunc, ' ' },
          -- condition = { builtin.not_empty, true, builtin.not_empty },
          click = 'v:lua.ScFa',
        },

        -- { text = { '  ', '%s', '  ' }, click = 'v:lua.ScSa' },
      },
    }
  end,
}
