-- adds various ui enhancements such as a popup for the cmd line, lsp progress
return {
  enabled = true,
  'folke/noice.nvim',
  event = 'VeryLazy',
  dependencies = { 'MunifTanjim/nui.nvim' },
  opts = {
    presets = {
      bottom_search = true, -- use a classic bottom cmdline for search
      command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = false, -- long messages will be sent to a split
      inc_rename = false, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = true, -- add a border to hover docs and signature help
    },
    lsp = {
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = true,
      },
      signature = {
        enabled = true,
      },
    },
    cmdline = {
      view = 'cmdline',
      enabled = true,
      format = {
        search_down = { icon = ' ' },
        search_up = { icon = ' ' },
      },
    },
    commands = {
      nots = {
        view = 'split',
        opts = { enter = true, format = 'details' },
        filter = {
          any = {
            { event = 'notify' },
          },
        },
      },
    },
    routes = {
      {
        view = 'notify',
        filter = { event = 'msg_showmode' },
      },
      -- supress annoying messages
      {
        filter = {
          event = 'msg_show',
          find = '[.]*L, [.]*B',
        },
        opts = { skip = true },
      },
      {
        filter = {
          event = 'msg_show',
          find = 'second[s]? ago',
        },
        opts = { skip = true },
      },
      {
        filter = {
          event = 'msg_show',
          find = 'yanked',
        },
        opts = { skip = true },
      },
      {
        filter = {
          event = 'notify',
          find = 'No information available',
        },
        opts = { skip = true },
      },
      {
        filter = {
          event = 'msg_show',
          find = 'more line[s]?',
        },
        opts = { skip = true },
      },
      {
        filter = {
          event = 'msg_show',
          find = 'fewer lines',
        },
        opts = { skip = true },
      },
      {
        filter = {
          event = 'msg_show',
          find = 'line less',
        },
        opts = { skip = true },
      },
      {
        filter = {
          event = 'msg_show',
          find = 'newest change',
        },
        opts = { skip = true },
      },
      {
        filter = {
          event = 'msg_show',
          find = 'written',
        },
        opts = { skip = true },
      },
      {
        filter = {
          event = 'msg_show',
          kind = '',
        },
        opts = { skip = true },
      },
    },
    views = {
      cmdline_popup = {
        position = {
          row = 20,
          col = '50%',
        },
        size = {
          width = 40,
          height = 'auto',
        },
      },
      -- popupmenu = {
      --   relative = 'editor',
      --   position = {
      --     row = 20,
      --     col = '50%',
      --   },
      --   size = {
      --     width = 40,
      --     height = 10,
      --   },
      --   border = {
      --     style = 'rounded',
      --     padding = { 0, 1 },
      --   },
      --   win_options = {
      --     -- winhighlight = { Normal = 'Normal', FloatBorder = 'DiagnosticInfo' },
      --   },
      -- },
    },
  },
}
