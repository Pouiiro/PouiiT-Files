return {
  'TheLazyCat00/replace-nvim',
  event = 'VeryLazy',
  opts = {},
  keys = {
    {
      't',
      function()
        return require('replace-nvim').replace(true)
      end,
      mode = { 'n', 'x' },
      expr = true, -- ⚠️ set expr to true
      desc = 'Replace with clipboard',
    },
  },
}
