return {
  'wsdjeg/scrollbar.vim',
  event = 'VeryLazy',
  config = function()
    require('scrollbar').setup {
      max_size = 10,
      min_size = 5,
      width = 1,
      right_offset = 1,
      excluded_filetypes = {
        'startify',
        'git-commit',
        'leaderf',
        'NvimTree',
        'tagbar',
        'defx',
        'neo-tree',
        'qf',
      },
      shape = {
        head = '',
        body = '█',
        tail = '',
      },
      highlight = {
        head = 'Normal',
        body = 'Normal',
        tail = 'Normal',
      },
    }
  end,
}
