return {
  'akinsho/bufferline.nvim',
  event = 'VeryLazy',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    vim.cmd [[
  highlight TabLineFill guibg=NONE ctermbg=NONE
  highlight TabLine guibg=NONE ctermbg=NONE
  highlight TabLineSel guibg=NONE ctermbg=NONE
]]

    require('bufferline').setup {
      options = {
        mode = 'buffers',
        numbers = 'none',
        close_command = function(n)
          require('bufdelete').bufdelete(n, true)
        end,
        right_mouse_command = nil,
        indicator = {
          style = 'none', -- ✅ remove underline
        },
        get_element_icon = function(element)
          local icon, hl = require('nvim-web-devicons').get_icon_by_filetype(element.filetype, { default = true })
          if icon then
            -- add a trailing space to separate icon and filename nicely
            return icon .. ' ', hl
          else
            return '', nil
          end
        end,
        buffer_close_icon = '', -- ✅ no "X"
        modified_icon = '●',
        close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',
        separator_style = { '|', '|' }, -- ✅ vertical red line
        enforce_regular_tabs = true,
        always_show_bufferline = true,
        show_buffer_close_icons = false,
        show_close_icon = false,
        show_buffer_icons = true,
        show_tab_indicators = false,
        max_name_length = 30,
        max_prefix_length = 15,
        tab_size = 20,
        diagnostics = false,
      },
      highlights = {
        fill = {
          bg = 'NONE',
        },
        background = {
          fg = '#565f89',
          bg = 'NONE',
        },
        buffer = {
          fg = '#565f89',
          bg = 'NONE',
        },
        buffer_visible = {
          fg = '#737aa2',
          bg = 'NONE',
        },
        buffer_selected = {
          fg = '#c0caf5', -- tokyonight-night fg
          bg = 'NONE',
          bold = true,
          italic = false,
        },
        separator = {
          fg = '#ff0000',
          bg = 'NONE',
        },
        separator_visible = {
          fg = '#ff0000',
          bg = 'NONE',
        },
        separator_selected = {
          fg = '#ff0000',
          bg = 'NONE',
        },
        indicator_visible = {
          fg = 'NONE',
          bg = 'NONE',
        },
        indicator_selected = {
          fg = 'NONE',
          bg = 'NONE',
        },
        close_button = {
          fg = 'NONE',
          bg = 'NONE',
        },
        close_button_visible = {
          fg = 'NONE',
          bg = 'NONE',
        },
        close_button_selected = {
          fg = 'NONE',
          bg = 'NONE',
        },
        tab_close = {
          fg = 'NONE',
          bg = 'NONE',
        },
      },
    }
  end,
}
