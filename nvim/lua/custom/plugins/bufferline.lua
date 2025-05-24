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
        fill = {
          fg = '#ff0000',
          bg = '#000000',
        },
        background = {
          fg = '#aeaeae',
          bg = '#000000',
        },
        -- tab = {
        --   fg = '<colour-value-here>',
        --   bg = '<colour-value-here>',
        -- },
        -- tab_selected = {
        --   fg = '<colour-value-here>',
        --   bg = '<colour-value-here>',
        -- },
      },
    }
  end,
}
