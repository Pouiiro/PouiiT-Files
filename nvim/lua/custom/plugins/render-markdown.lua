-- return {
--   'MeanderingProgrammer/render-markdown.nvim',
--   lazy = false,
--   opts = {
--     file_types = { 'markdown', 'copilot-chat', 'codecompanion' },
--     completions = { lsp = { enabled = true } },
--     anti_conceal = { enabled = false },
--     preset = 'round',
--   },
--   ft = { 'markdown', 'copilot-chat' },
-- }

return {
  'OXY2DEV/markview.nvim',
  lazy = true,
  ft = { 'markdown', 'copilot-chat' },
  opts = {
    preview = {
      filetypes = { 'md', 'markdown', 'copilot-chat' },
    },
  },
}
