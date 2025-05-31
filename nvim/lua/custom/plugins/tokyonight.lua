return {
  'folke/tokyonight.nvim',
  lazy = false,
  priority = 1000,
  ---@class tokyonight.Config
  ---@field on_colors fun(colors: ColorScheme)
  ---@field on_highlights fun(highlights: tokyonight.Highlights, colors: ColorScheme)
  opts = {
    transparent = true,
    style = 'night',
    plugins = {
      snacks = true,
      nvimtree = true,
    },

    --- You can override specific color groups to use other groups or a hex color
    --- function will be called with a ColorScheme table
    ---@param colors ColorScheme
    on_colors = function(colors) end,
    --- You can override specific highlights to use other groups or a hex color
    --- function will be called with a Highlights and ColorScheme table
    ---@param highlights tokyonight.Highlights
    ---@param colors ColorScheme
    on_highlights = function(hl, c)
      hl.FloatBorder = { fg = c.purple, bg = 'NONE' }
      hl.NormalFloat = { fg = c.fg_dark, bg = 'NONE' }
      hl.NvimTreeNormal = { bg = 'NONE' }
      hl.NvimTreeNormalNC = { bg = 'NONE' }
      hl.NvimTreeWinSeparator = { bg = 'NONE', fg = c.purple }
      hl.BufferLineOffsetSeparator = { bg = 'NONE', fg = c.purple }
      hl.NvimTreeOpenedFile = { bg = 'NONE' }
      hl.SnacksPickerInputerBorder = { bg = 'NONE' }
      hl.NvimTreeOpenedFolderName = { fg = c.orange }
      hl.NvimTreeOpenedFolderIcon = { fg = c.orange }
      hl.NvimTreeOpenedFile = { fg = c.orange }
      hl.SnacksPickerBoxTitle = { bg = 'NONE' }
      hl.SnacksPickerInputBorder = { bg = 'NONE' }
      hl.SnacksPickerInputTitle = { bg = 'NONE' }
      hl.BlinkCmpDoc = { bg = 'NONE' }
      hl.BlinkCmpMenu = { bg = 'NONE' }
      hl.BlinkCmpDocBorder = { bg = 'NONE', fg = c.purple }
      hl.BlinkCmpMenuBorder = { bg = 'NONE', fg = c.purple }
      hl.BlinkCmpSignatureHelp = { bg = 'NONE' }
      hl.BlinkCmpSignatureHelpBorder = { bg = 'NONE', fg = c.purple }
      hl.Pmenu = { bg = 'NONE' }
      hl.CursorLine = { bg = '#39254a' }
      hl.Comment = { fg = '#6b6b6b', bg = 'NONE', italic = true, bold = true }
      hl.CopilotSuggestion = { bg = 'NONE', link = 'Comment' }
      hl.CopilotAnnotation = { bg = 'NONE', link = 'Comment' }
      hl.Folded = { italic = true, bg = '#39254a', fg = c.orange }
      hl.FlashLabel = { fg = '#FF0000', bold = true, italic = true, bg = '#1E3A8A' }
      hl.FlashMatch = { bg = 'NONE', fg = c.purple }
      hl.FlashCurrent = { bg = 'NONE', fg = c.purple }
      hl.VerticalSplit = { fg = c.purple, bg = 'NONE' }
      hl.WinSeparator = { fg = c.purple, bg = 'NONE' }
    end,
  },
  config = function(_, opts)
    require('tokyonight').setup(opts)
    vim.cmd.colorscheme 'tokyonight'
  end,
}
