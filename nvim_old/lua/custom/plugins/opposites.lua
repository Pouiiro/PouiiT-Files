return {
  'tigion/nvim-opposites',
  event = { 'BufReadPost', 'BufNewFile' },
  keys = {
    {
      '<Leader>i',
      function()
        require('opposites').switch()
      end,
      desc = 'Switch to opposite word',
    },
  },
  ---@type opposites.Config
  opts = {
    opposites = {
      ['enable'] = 'disable',
      ['true'] = 'false',
      ['yes'] = 'no',
      ['on'] = 'off',
      ['left'] = 'right',
      ['up'] = 'down',
      ['min'] = 'max',
      ['=='] = '!=',
      ['<='] = '>=',
      ['<'] = '>',
    },
  },
}
