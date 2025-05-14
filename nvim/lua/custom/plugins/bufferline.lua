return {
  'akinsho/bufferline.nvim',
  event = 'VeryLazy',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    require('bufferline').setup {
      options = {
        themable = true,
        indicator = {
          icon = '',
          style = 'icon',
        },
        diagnostics = 'nvim_lsp',
        separator_style = { '', '' },
        offsets = {
          {
            filetype = 'NvimTree',
            text = 'Files Tree',
            highlight = 'Directory',
            separator = true,
          },
        },
        custom_areas = {
          right = function()
            local result = {}
            local time = os.date '%I:%M%p'

            table.insert(result, { text = time .. ' 󰄛 ', fg = '#5fdfae', bold = true })

            return result
          end,
        },
      },
      highlights = {
        buffer_selected = {
          fg = '#9f5fdf',
          bold = true,
          italic = false,
        },
      },
    }
  end,
}
