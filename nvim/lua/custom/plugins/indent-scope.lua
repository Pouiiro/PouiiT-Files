-- indent char from settings
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

-- not set plugin if clean mode is enabled
if settings.aspect == 'clean' then
  return {}
end

return {
  'echasnovski/mini.indentscope',
  event = 'VeryLazy',
  config = function()
    -- custom config
    require('mini.indentscope').setup {
      symbol = settings.indentChar,
      options = {
        try_as_border = true,
        indent_at_cursor = false,
      },
      draw = {
        delay = 0,
        animation = function()
          return 20
        end,
      },
    }

    -- disable for some buffer types
    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'help', 'dashboard', 'nvimtree', 'mason', 'lspsaga', 'lspinfo', 'toggleterm' },
      callback = function()
        vim.b.miniindentscope_disable = true
      end,
    })
  end,
}
