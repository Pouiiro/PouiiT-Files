return {
  'saghen/blink.cmp',
  lazy = false,
  build = 'cargo build --release',
  enabled = false,
  dependencies = {
    'rafamadriz/friendly-snippets',
  },
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = { preset = 'enter', ['<C-e>'] = { 'cancel', 'fallback' } },
    appearance = {
      nerd_font_variant = 'mono',
    },
    completion = {
      menu = { border = 'single' },
      documentation = { auto_show = true, window = { border = 'single' } },
      accept = { auto_brackets = { enabled = true } },
    },
    signature = { window = { border = 'single' } },
    cmdline = {
      keymap = { preset = 'inherit' },
      completion = { menu = { auto_show = true } },
    },
    fuzzy = { implementation = 'prefer_rust_with_warning' },
  },
  opts_extend = { 'sources.default' },
}
