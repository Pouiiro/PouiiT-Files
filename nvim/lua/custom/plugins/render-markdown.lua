return {
  'MeanderingProgrammer/render-markdown.nvim',
  lazy = false,
  opts = {
    file_types = { 'markdown', 'copilot-chat', 'codecompanion' },
    completions = { lsp = { enabled = true } },
    anti_conceal = { enabled = false },
    preset = 'round',
  },
  ft = { 'markdown', 'copilot-chat' },
}
