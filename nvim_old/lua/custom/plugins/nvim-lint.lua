return {
  'mfussenegger/nvim-lint',
  event = 'VeryLazy',
  config = function()
    local lint = require 'lint'
    -- vim.env.ESLINT_D_PPID = vim.fn.getpid()

    lint.linters_by_ft = {
      javascript = { 'biomejs' },
      typescript = { 'biomejs' },
      javascriptreact = { 'biomejs' },
      typescriptreact = { 'biomejs' },
      gherkin = {
        command = 'gherkin-lint',
        args = {},
        filetypes = { 'feature' },
      },
    }

    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
