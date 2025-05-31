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
          style = 'none',
        },
        diagnostics = 'nvim_lsp',
        separator_style = 'slope',
        separator = 'slope',
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
        fill = {
          fg = '#000000',
          bg = '#000000',
        },
        separator_selected = {
          fg = '#000000',
        },
        separator = {
          fg = '#000000',
        },
        separator_visible = {
          fg = '#000000',
        },
      },
    }
  end,
}
