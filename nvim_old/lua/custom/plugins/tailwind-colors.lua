return {
  enabled = false,
  'themaxmarchuk/tailwindcss-colors.nvim',
  event = 'VeryLazy',
  config = function()
    require('tailwindcss-colors').setup()
  end,
}
