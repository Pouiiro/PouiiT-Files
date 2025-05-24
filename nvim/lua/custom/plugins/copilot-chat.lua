local prompts = {
  -- Code related prompts
  Explain = 'Please explain how the following code works.',
  Review = 'Please review the following code and provide suggestions for improvement.',
  Tests = 'Please explain how the selected code works, then generate unit tests for it.',
  Refactor = 'Please refactor the following code to improve its clarity and readability.',
  FixCode = 'Please fix the following code to make it work as intended.',
  FixError = 'Please explain the error in the following text and provide a solution.',
  BetterNamings = 'Please provide better names for the following variables and functions.',
  Documentation = 'Please provide documentation for the following code.',
  SwaggerApiDocs = 'Please provide documentation for the following API using Swagger.',
  SwaggerJsDocs = 'Please write JSDoc for the following API using Swagger.',
  -- Text related prompts
  Summarize = 'Please summarize the following text.',
  Spelling = 'Please correct any grammar and spelling errors in the following text.',
  Wording = 'Please improve the grammar and wording of the following text.',
  Concise = 'Please rewrite the following text to make it more concise.',
}

local optsD = {
  question_header = '## Pouiiro ',
  answer_header = '## Copilot ',
  error_header = '## Error ',
  prompts = prompts,
  auto_follow_cursor = true, -- Don't follow the cursor after getting response
  model = 'gpt-4.1',
  window = {
    layout = 'vertical', -- 'vertical', 'horizontal', 'float', 'replace'
    width = 0.5, -- fractional width of parent, or absolute width in columns when > 1
    height = 0.5, -- fractional height of parent, or absolute height in rows when > 1
  },
  mappings = {
    -- Use tab for completion
    complete = {
      detail = 'Use @<Tab> or /<Tab> for options.',
      insert = '<Tab>',
    },
    -- Close the chat
    close = {
      normal = 'q',
      insert = '<C-c>',
    },
    -- Reset the chat buffer
    reset = {
      normal = '<C-x>',
      insert = '<C-x>',
    },
    -- Submit the prompt to Copilot
    submit_prompt = {
      normal = '<CR>',
      insert = '<C-CR>',
    },
    -- Accept the diff
    accept_diff = {
      normal = '<C-y>',
      insert = '<C-y>',
    },
    -- Yank the diff in the response to register
    yank_diff = {
      normal = 'gmy',
    },
    -- Show the diff
    show_diff = {
      normal = 'gmd',
    },
    -- Show the info
    show_info = {
      normal = 'gmi',
    },
    -- Show the context
    show_context = {
      normal = 'gmc',
    },
    -- Show help
    show_help = {
      normal = 'gmh',
    },
  },
  chat_autocomplete = true,
}

local config = function(_, opts)
  local chat = require 'CopilotChat'
  local select = require 'CopilotChat.select'
  -- Use unnamed register for the selection
  opts.selection = select.unnamed

  chat.setup(opts)

  vim.api.nvim_create_user_command('CopilotChatVisual', function(args)
    chat.ask(args.args, { selection = select.visual })
  end, { nargs = '*', range = true })

  -- Inline chat with Copilot
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

  -- Restore CopilotChatBuffer
  vim.api.nvim_create_user_command('CopilotChatBuffer', function(args)
    chat.ask(args.args, { selection = select.buffer })
  end, { nargs = '*', range = true })

  -- Custom buffer for CopilotChat
  vim.api.nvim_create_autocmd('BufEnter', {
    pattern = 'copilot-*',
    callback = function()
      vim.opt_local.relativenumber = true
      vim.opt_local.number = true

      -- Get current filetype and set it to markdown if the current filetype is copilot-chat
      local ft = vim.bo.filetype
      if ft == 'copilot-chat' then
        vim.bo.filetype = 'markdown'
      end
    end,
  })
end

local keys = {
  -- Show prompts actions with telescope
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
  -- Code related commands
  { '<leader>cce', '<cmd>CopilotChatExplain<cr>', desc = 'CopilotChat - Explain code' },
  { '<leader>cct', '<cmd>CopilotChatTests<cr>', desc = 'CopilotChat - Generate tests' },
  { '<leader>ccr', '<cmd>CopilotChatReview<cr>', desc = 'CopilotChat - Review code' },
  { '<leader>ccR', '<cmd>CopilotChatRefactor<cr>', desc = 'CopilotChat - Refactor code' },
  { '<leader>ccn', '<cmd>CopilotChatBetterNamings<cr>', desc = 'CopilotChat - Better Naming' },
  -- Chat with Copilot in visual mode
  {
    '<leader>ccv',
    ':CopilotChatVisual',
    mode = 'x',
    desc = 'CopilotChat - Open in vertical split',
  },
  {
    '<leader>ccx',
    ':CopilotChatInline<cr>',
    mode = 'x',
    desc = 'CopilotChat - Inline chat',
  },
  -- Custom input for CopilotChat
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
  -- Generate commit message based on the git diff
  {
    '<leader>ccm',
    '<cmd>CopilotChatCommit<cr>',
    desc = 'CopilotChat - Generate commit message for all changes',
  },
  -- Quick chat with Copilot
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
  -- Debug
  { '<leader>ccd', '<cmd>CopilotChatDebugInfo<cr>', desc = 'CopilotChat - Debug Info' },
  -- Fix the issue with diagnostic
  { '<leader>ccf', '<cmd>CopilotChatFix<cr>', desc = 'CopilotChat - Fix Diagnostic' },
  -- Clear buffer and chat history
  { '<leader>ccl', '<cmd>CopilotChatReset<cr>', desc = 'CopilotChat - Clear buffer and chat history' },
  -- Toggle Copilot Chat Vsplit
  { '<leader>ccv', '<cmd>CopilotChatToggle<cr>', desc = 'CopilotChat - Toggle' },
  -- Copilot Chat Models
  { '<leader>cc?', '<cmd>CopilotChatModels<cr>', desc = 'CopilotChat - Select Models' },
}

function IsCodePublic(cwd, public_paths)
  for _, public_path in ipairs(public_paths) do
    local expanded_public_path = vim.fn.expand(public_path) -- Expand the tilde
    -- Check if the current directory starts with the expanded public path
    local public_path_detected = string.find(cwd, expanded_public_path, 1, true) == 1
    if public_path_detected then
      return true
    end
  end
  return false
end

return {
  'CopilotC-Nvim/CopilotChat.nvim',
  branch = 'main',
  event = 'VeryLazy',
  cond = function()
    local cwd = vim.fn.getcwd()
    -- Add your own paths to the public_paths table to customize the behavior.
    local enabledDirs = {
      '~/.config/nvim',
      '~/dev',
      '**/nvim/**',
      '~/dotfiles',
    }

    return IsCodePublic(cwd, enabledDirs)
  end,
  dependencies = {
    { 'zbirenbaum/copilot.lua' }, -- or github/copilot.vim
    { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
  },
  build = 'make tiktoken',
  opts = optsD,
  keys = keys,
  config = config,
}
