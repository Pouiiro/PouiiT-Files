local settings = {
  theme = 'tokyonight', -- ayu|gruvbox|neofusion
  indentChar = '│', -- │, |, ¦, ┆, ┊
  separatorChar = '-', -- ─, -, .
  aspect = 'clean', -- normal|clean
  lualine_separator = 'rect', -- rect|triangle|semitriangle|curve
  cmp_style = 'nvchad', -- default|nvchad
  cmp_icons_style = 'vscode', -- devicons|vscode
  transparent_mode = true,
}
-- for conciseness
local opt = vim.opt -- vim options

-- set options
opt.completeopt = 'menu,menuone,noselect'

-- vscode like icons
local cmp_kinds = {
  Text = '',
  Method = '',
  Function = '',
  Constructor = '',
  Field = '',
  Variable = '',
  Class = '',
  Interface = '',
  Module = '',
  Property = '',
  Unit = '',
  Value = '',
  Enum = '',
  Keyword = '',
  Snippet = '󰘦 ',
  Color = '',
  File = '',
  Reference = '',
  Folder = '',
  EnumMember = '',
  Constant = '',
  Struct = '',
  Event = '',
  Operator = '',
  TypeParameter = '',
}

return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'onsails/lspkind.nvim',
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    'rafamadriz/friendly-snippets',
    'mlaursen/vim-react-snippets',
    'roobert/tailwindcss-colorizer-cmp.nvim',
    'hrsh7th/cmp-cmdline',
    'zbirenbaum/copilot.lua',
    {
      'folke/lazydev.nvim',
      ft = 'lua', -- only load on lua files
      opts = {
        library = {
          -- See the configuration section for more details
          -- Load luvit types when the `vim.uv` word is found
          { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        },
      },
    },
  },
  event = 'InsertEnter',
  config = function()
    -- require cmp
    local cmp = require 'cmp'

    -- require luasnip
    local luasnip = require 'luasnip'

    -- require lspkind
    local lspkind = require 'lspkind'

    -- require tailwind colorizer for cmp
    local tailwindcss_colorizer_cmp = require 'tailwindcss-colorizer-cmp'

    -- load friendly-snippets
    require('luasnip.loaders.from_vscode').lazy_load()

    -- require react-snippets
    require('vim-react-snippets').lazy_load()

    vim.api.nvim_set_hl(0, 'CursorLineBG', { bg = '#3b275f' }) -- dark purple

    -- custom setup
    cmp.setup {
      window = {
        completion = {
          border = 'rounded', -- single|rounded|none
          -- custom colors
          winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:CursorLineBG,Search:None', -- BorderBG|FloatBorder
          side_padding = settings.cmp_style == 'default' and 1 or 0, -- padding at sides
          col_offset = settings.cmp_style == 'default' and -1 or -4, -- move floating box left or right
        },
        documentation = {
          border = 'rounded', -- single|rounded|none
          -- custom colors
          winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:CursorLineBG,Search:None', -- BorderBG|FloatBorder
        },
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert {
        ['<S-tab>'] = cmp.mapping.select_prev_item(), -- select previous suggestion (2)
        ['<tab>'] = cmp.mapping.select_next_item(), -- select next suggestion (2)
        ['<C-l>'] = cmp.mapping.scroll_docs(-4), -- scroll docs down
        ['<C-h>'] = cmp.mapping.scroll_docs(4), -- scroll docs up
        ['<C-e>'] = cmp.mapping.abort(), -- close completion window
        ['<C-Space>'] = cmp.mapping.complete(), -- show completion suggestions
        ['<CR>'] = cmp.mapping.confirm { select = false }, -- confirm suggestion
        -- require("copilot.suggestion").is_visible()
        -- require("copilot.suggestion").accept(modifier)
        -- require("copilot.suggestion").accept_word()
        -- require("copilot.suggestion").accept_line()
        -- require("copilot.suggestion").next()
        -- require("copilot.suggestion").prev()
        -- require("copilot.suggestion").dismiss()
        -- require("copilot.suggestion").toggle_auto_trigger()
      },
      sources = cmp.config.sources {
        { name = 'nvim_lsp' }, -- lsp
        { name = 'luasnip' }, -- luasnips
        { name = 'ecolog' },
        { name = 'git' },
        { name = 'buffer' }, -- text within the current buffer
        { name = 'path' }, -- file system paths
        { name = 'lazydev', group_index = 0 },
      },
      formatting = {
        fields = settings.cmp_style == 'nvchad' and { 'kind', 'abbr', 'menu' } or nil,
        format = function(entry, item)
          local fmt = lspkind.cmp_format {
            mode = 'symbol_text',
            maxwidth = 50,
            ellipsis_char = '...',
            before = tailwindcss_colorizer_cmp.formatter,
          }(entry, item)

          -- fallback for missing kinds (usually snippets)
          if entry.source.name == 'luasnip' and not item.kind then
            item.kind = 'Snippet'
          end

          local strings = vim.split(fmt.kind, '%s', { trimempty = true })

          if settings.cmp_icons_style == 'vscode' then
            fmt.kind = ' ' .. (cmp_kinds[strings[2]] or '') -- fallback icon
          else
            fmt.kind = ' ' .. (strings[1] or '')
          end

          if settings.cmp_style == 'nvchad' then
            fmt.kind = fmt.kind .. ' '
            fmt.menu = strings[2] and ('  ' .. strings[2]) or ''
          else
            fmt.menu = strings[2] or ''
          end

          return fmt
        end,
      },
    }

    -- `/` cmdline setup.
    cmp.setup.cmdline('/', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' },
      },
    })

    -- `:` cmdline setup.
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' },
      }, {
        {
          name = 'cmdline',
          option = {
            ignore_cmds = { 'Man', '!' },
          },
        },
      }),
    })
  end,
}
