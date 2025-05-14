return {
  'catppuccin/nvim',
  lazy = false,
  name = 'catppuccin',
  priority = 1000,
  config = function()
    require('catppuccin').setup {
      flavour = 'mocha', -- latte, frappe, macchiato, mocha
      background = { -- :h background
        light = 'latte',
        dark = 'mocha',
      },
      transparent_background = true, -- disables setting the background color.
      show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
      term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
      dim_inactive = {
        enabled = false, -- dims the background color of inactive window
        shade = 'dark',
        percentage = 0.1, -- percentage of the shade to apply to the inactive window
      },
      floating_border = 'on',
      no_italic = false, -- Force no italic
      no_bold = false, -- Force no bold
      no_underline = false, -- Force no underline
      styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { 'italic' }, -- Change the style of comments
        conditionals = { 'italic' },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
        -- miscs = {}, -- Uncomment to turn off hard-coded styles
      },
      color_overrides = {
        -- mocha = {
        --   base = '#000000',
        --   mantle = '#000000',
        --   crust = '#000000',
        -- },
      },
      custom_highlights = {
        FlashLabel = { bold = true },
        BufferCurrentNumber = { fg = '#ff0000' },
      },
      default_integrations = true,
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = true,
        telescope = {
          enabled = true,
          style = 'nvchad',
          border = true,
        },
        blink_cmp = true,
        mini = {
          enabled = true,
          indentscope_color = '',
        },
        fidget = true,
        flash = true,
      },
      noice = true,
      notifier = true,
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { 'italic' },
          hints = { 'italic' },
          warnings = { 'italic' },
          information = { 'italic' },
          ok = { 'italic' },
        },

        underlines = {
          errors = { 'underline' },
          hints = { 'underline' },
          warnings = { 'underline' },
          information = { 'underline' },
          ok = { 'underline' },
        },

        inlay_hints = {
          background = true,
        },
      },
      ufo = true,
      snacks = {
        enabled = true,
        indent_scope_color = 'lavender',
      },
    }

    -- setup must be called before loading
    -- vim.cmd.colorscheme 'catppuccin'
    --
    --   local colors = require('catppuccin.palettes').get_palette()
    --   local TelescopeColor = {
    --     TelescopeMatching = { fg = colors.flamingo },
    --     TelescopeSelection = { fg = colors.text, bg = colors.surface0, bold = true },
    --
    --     TelescopePromptPrefix = { bg = colors.surface0 },
    --     TelescopePromptNormal = { bg = colors.surface0 },
    --     TelescopeResultsNormal = { bg = colors.mantle },
    --     TelescopePreviewNormal = { bg = colors.mantle },
    --     TelescopePromptBorder = { bg = colors.surface0, fg = colors.surface0 },
    --     TelescopeResultsBorder = { bg = colors.mantle, fg = colors.mantle },
    --     TelescopePreviewBorder = { bg = colors.mantle, fg = colors.mantle },
    --     TelescopePromptTitle = { bg = colors.pink, fg = colors.mantle },
    --     TelescopeResultsTitle = { fg = colors.mantle },
    --     TelescopePreviewTitle = { bg = colors.green, fg = colors.mantle },
    --   }
    --
    --   for hl, col in pairs(TelescopeColor) do
    --     vim.api.nvim_set_hl(0, hl, col)
    --   end
  end,
}
