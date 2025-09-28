-- Copilot Chat Plugin Configuration

-- Prompts
local prompts = {
  -- General Code
  Explain = 'Explain what the following code does, step by step.',
  Review = 'Review the following code for best practices, performance, and readability. Suggest improvements.',
  Refactor = 'Refactor the following code for clarity, maintainability, and efficiency.',
  FixCode = 'Find and fix bugs or issues in the following code.',
  AddTypes = 'Add or improve TypeScript types for the following code.',
  GenerateTests = 'Write comprehensive unit tests for the following code using Vitest.',
  GenerateE2ETests = 'Write Playwright end-to-end tests for the following code.',
  ImproveNaming = 'Suggest better variable and function names for the following code.',
  AddDocs = 'Generate detailed documentation comments for the following code.',
  ConvertToReact = 'Convert the following code to a React functional component.',
  AddReactHooks = 'Suggest and implement appropriate React hooks for the following code.',
  OptimizeReact = 'Optimize the following React component for performance and readability.',
  MigrateToTS = 'Migrate the following JavaScript code to TypeScript.',
  -- API & Swagger
  SwaggerApiDocs = 'Generate Swagger/OpenAPI documentation for the following API code.',
  SwaggerJsDocs = 'Write JSDoc comments for the following API using Swagger conventions.',
  -- Text
  Summarize = 'Summarize the following text in a concise way.',
  CorrectSpelling = 'Correct grammar and spelling errors in the following text.',
  ImproveWording = 'Improve grammar, style, and wording of the following text.',
  MakeConcise = 'Rewrite the following text to be more concise and clear.',
  -- Playwright
  DebugPlaywright = 'Debug the following Playwright test and suggest fixes.',
  -- Vitest
  DebugVitest = 'Debug the following Vitest test and suggest fixes.',
  -- React/TS
  FindReactBugs = 'Find bugs and anti-patterns in the following React/TypeScript code.',
  SuggestReactTests = 'Suggest useful test cases for the following React component.',
}

-- Options
local optsD = {
  question_header = '## Pouiiro ',
  answer_header = '## Copilot ',
  error_header = '## Error ',
  prompts = prompts,
  auto_follow_cursor = true,
  model = 'gpt-4.1',
  window = {
    layout = 'vertical',
    width = 0.5,
    height = 0.5,
  },
  mappings = {
    complete = { detail = 'Use @<Tab> or /<Tab> for options.', insert = '<Tab>' },
    close = { normal = 'q', insert = '<C-c>' },
    reset = { normal = '<C-x>', insert = '<C-x>' },
    submit_prompt = { normal = '<CR>', insert = '<C-CR>' },
    accept_diff = { normal = '<C-y>', insert = '<C-y>' },
    yank_diff = { normal = 'gmy' },
    show_diff = { normal = 'gmd' },
    show_info = { normal = 'gmi' },
    show_context = { normal = 'gmc' },
    show_help = { normal = 'gmh' },
  },
  chat_autocomplete = true,
}

-- Plugin Setup
local config = function(_, opts)
  local chat = require 'CopilotChat'
  local select = require 'CopilotChat.select'
  opts.selection = select.unnamed

  chat.setup(opts)

  vim.api.nvim_create_user_command('CopilotChatVisual', function(args)
    chat.ask(args.args, { selection = select.visual })
  end, { nargs = '*', range = true })

  vim.api.nvim_create_user_command('CopilotChatInline', function(args)
    chat.ask(args.args, {
      selection = select.visual,
      window = {
        layout = 'float',
        relative = 'cursor',
        width = 1,
        height = 0.4,
        row = 1,
      },
    })
  end, { nargs = '*', range = true })

  vim.api.nvim_create_user_command('CopilotChatBuffer', function(args)
    chat.ask(args.args, { selection = select.buffer })
  end, { nargs = '*', range = true })

  vim.api.nvim_create_autocmd('BufEnter', {
    pattern = 'copilot-*',
    callback = function()
      vim.opt_local.relativenumber = true
      vim.opt_local.number = true
      if vim.bo.filetype == 'copilot-chat' then
        vim.bo.filetype = 'markdown'
      end
    end,
  })
end

-- Keymaps
local keys = {
  -- Top-level group keymap for CopilotChat
  { '<leader>c', desc = 'CopilotChat' },

  -- Prompt actions
  {
    '<leader>ccp',
    function()
      require('CopilotChat').select_prompt()
    end,
    desc = 'CopilotChat - Prompt actions',
  },
  {
    '<leader>ccp',
    ":lua require('CopilotChat.integrations.telescope').pick(require('CopilotChat.actions').prompt_actions({selection = require('CopilotChat.select').visual}))<CR>",
    mode = 'x',
    desc = 'CopilotChat - Prompt actions',
  },

  -- Code
  { '<leader>cce', '<cmd>CopilotChatExplain<cr>', desc = 'CopilotChat - Explain code' },
  { '<leader>ccr', '<cmd>CopilotChatReview<cr>', desc = 'CopilotChat - Review code' },
  { '<leader>ccR', '<cmd>CopilotChatRefactor<cr>', desc = 'CopilotChat - Refactor code' },
  { '<leader>ccn', '<cmd>CopilotChatImproveNaming<cr>', desc = 'CopilotChat - Improve Naming' },
  { '<leader>cct', '<cmd>CopilotChatGenerateTests<cr>', desc = 'CopilotChat - Generate unit tests' },
  { '<leader>ccT', '<cmd>CopilotChatGenerateE2ETests<cr>', desc = 'CopilotChat - Generate Playwright tests' },
  { '<leader>ccy', '<cmd>CopilotChatAddTypes<cr>', desc = 'CopilotChat - Add TypeScript types' },
  { '<leader>ccm', '<cmd>CopilotChatMigrateToTS<cr>', desc = 'CopilotChat - Migrate to TypeScript' },
  { '<leader>ccC', '<cmd>CopilotChatConvertToReact<cr>', desc = 'CopilotChat - Convert to React component' },
  { '<leader>ccH', '<cmd>CopilotChatAddReactHooks<cr>', desc = 'CopilotChat - Add React hooks' },
  { '<leader>ccO', '<cmd>CopilotChatOptimizeReact<cr>', desc = 'CopilotChat - Optimize React component' },
  { '<leader>ccD', '<cmd>CopilotChatAddDocs<cr>', desc = 'CopilotChat - Add documentation' },

  -- Chat
  { '<leader>ccx', ':CopilotChatInline<cr>', mode = 'x', desc = 'CopilotChat - Inline chat' },
  { '<leader>ccv', '<cmd>CopilotChatToggle<cr>', desc = 'CopilotChat - Toggle' },

  -- Input
  {
    '<leader>cci',
    function()
      local input = vim.fn.input 'Ask Copilot: '
      if input ~= '' then
        vim.cmd('CopilotChat ' .. input)
      end
    end,
    desc = 'CopilotChat - Ask input',
  },

  -- Commit message
  { '<leader>ccM', '<cmd>CopilotChatCommit<cr>', desc = 'CopilotChat - Generate commit message for all changes' },

  -- Quick chat
  {
    '<leader>ccq',
    function()
      local input = vim.fn.input 'Quick Chat: '
      if input ~= '' then
        vim.cmd('CopilotChatBuffer ' .. input)
      end
    end,
    desc = 'CopilotChat - Quick chat',
  },

  -- Debug & Fix
  { '<leader>ccd', '<cmd>CopilotChatDebugInfo<cr>', desc = 'CopilotChat - Debug Info' },
  { '<leader>ccf', '<cmd>CopilotChatFix<cr>', desc = 'CopilotChat - Fix Diagnostic' },
  { '<leader>ccP', '<cmd>CopilotChatDebugPlaywright<cr>', desc = 'CopilotChat - Debug Playwright test' },
  { '<leader>ccB', '<cmd>CopilotChatFindReactBugs<cr>', desc = 'CopilotChat - Find React/TS bugs' },
  { '<leader>ccS', '<cmd>CopilotChatSuggestReactTests<cr>', desc = 'CopilotChat - Suggest React test cases' },

  -- Clear
  { '<leader>ccl', '<cmd>CopilotChatReset<cr>', desc = 'CopilotChat - Clear buffer and chat history' },

  -- Models
  { '<leader>cc?', '<cmd>CopilotChatModels<cr>', desc = 'CopilotChat - Select Models' },
}

-- Utility: Check if code is public
local function IsCodePublic(cwd, public_paths)
  for _, public_path in ipairs(public_paths) do
    local expanded = vim.fn.expand(public_path)
    if string.find(cwd, expanded, 1, true) == 1 then
      return true
    end
  end
  return false
end

-- Plugin Spec
return {
  'CopilotC-Nvim/CopilotChat.nvim',
  branch = 'main',
  event = 'VeryLazy',
  cond = function()
    local cwd = vim.fn.getcwd()
    local enabledDirs = require 'utils.copilot-folders'
    return IsCodePublic(cwd, enabledDirs)
  end,
  dependencies = {
    { 'zbirenbaum/copilot.lua' },
    { 'nvim-lua/plenary.nvim' },
  },
  build = 'make tiktoken',
  opts = optsD,
  keys = keys,
  config = config,
}
