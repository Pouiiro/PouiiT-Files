return {
  'windwp/windline.nvim',
  event = 'VeryLazy',
  enabled = false,
  config = function()
    -- local windline = require 'windline'
    -- require 'wlsample.evil_line'
    -- require 'wlsample.airline_anim'
    require 'wlsample.bubble2'

    -- windline.setup {
    --   statuslines = require 'wlsample.airline_luffy',
    -- }
  end,
}
