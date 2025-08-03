-- various utilities
--

local dashboardConfig = {
  width = 60,
  row = nil, -- dashboard position. nil for center
  col = nil, -- dashboard position. nil for center
  pane_gap = 4, -- empty columns between vertical panes
  autokeys = '1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', -- autokey sequence
  -- These settings are used by some built-in sections
  preset = {
    -- Defaults to a picker that supports `fzf-lua`, `telescope.nvim` and `mini.pick`
    ---@type fun(cmd:string, opts:table)|nil
    pick = nil,
    -- Used by the `keys` section to show keymaps.
    -- Set your custom keymaps here.
    -- When using a function, the `items` argument are the default keymaps.
    ---@type snacks.dashboard.Item[]
    keys = {
      { icon = ' ', key = 'f', desc = 'Find File', action = ":lua Snacks.dashboard.pick('files')" },
      { icon = ' ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
      { icon = ' ', key = 'g', desc = 'Find Text', action = ":lua Snacks.dashboard.pick('live_grep')" },
      { icon = '', key = 'p', desc = 'List Projects', action = ':lua Snacks.picker.projects()' },
      { icon = ' ', key = 'r', desc = 'Recent Files', action = ":lua Snacks.dashboard.pick('oldfiles')" },
      { icon = ' ', key = 'c', desc = 'Config', action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
      { icon = ' ', key = 's', desc = 'Restore Session', section = 'session' },
      { icon = '󰒲 ', key = 'L', desc = 'Lazy', action = ':Lazy', enabled = package.loaded.lazy ~= nil },
      { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
    },
    header = [[
  ▄███████▄  ▄██████▄  ███    █▄   ▄█   ▄█     ▄████████  ▄██████▄
  ███    ███ ███    ███ ███    ███ ███  ███    ███    ███ ███    ███
  ███    ███ ███    ███ ███    ███ ███▌ ███▌   ███    ███ ███    ███
  ███    ███ ███    ███ ███    ███ ███▌ ███▌  ▄███▄▄▄▄██▀ ███    ███
▀█████████▀  ███    ███ ███    ███ ███▌ ███▌ ▀▀███▀▀▀▀▀   ███    ███
  ███        ███    ███ ███    ███ ███  ███  ▀███████████ ███    ███
  ███        ███    ███ ███    ███ ███  ███    ███    ███ ███    ███
 ▄████▀       ▀██████▀  ████████▀  █▀   █▀     ███    ███  ▀██████▀
                                               ███    ███           ]],
  },
  formats = {
    icon = function(item)
      if item.file and item.icon == 'file' or item.icon == 'directory' then
        return M.icon(item.file, item.icon)
      end
      return { item.icon, width = 2, hl = 'icon' }
    end,
    footer = { '%s', align = 'center' },
    header = { '%s', align = 'center' },
    file = function(item, ctx)
      local fname = vim.fn.fnamemodify(item.file, ':~')
      fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname
      if #fname > ctx.width then
        local dir = vim.fn.fnamemodify(fname, ':h')
        local file = vim.fn.fnamemodify(fname, ':t')
        if dir and file then
          file = file:sub(-(ctx.width - #dir - 2))
          fname = dir .. '/…' .. file
        end
      end
      local dir, file = fname:match '^(.*)/(.+)$'
      return dir and { { dir .. '/', hl = 'dir' }, { file, hl = 'file' } } or { { fname, hl = 'file' } }
    end,
  },
  sections = {
    {

      { section = 'header' },
      -- requires chafa -> brew install chafa
      -- {
      --   section = 'terminal',
      --   cmd = 'chafa -f symbols --symbols sextant -c full --speed=0.7 --clear --stretch "$HOME/.config/nvim/images/wiir.gif"; sleep .1',
      --   height = 32,
      --   width = 72,
      --   padding = 1,
      -- },
    },
    {
      pane = 1,
      { section = 'keys', gap = 1, padding = 1 },
      { section = 'startup' },
    },
    -- { section = 'header' },
    -- { section = 'keys', gap = 1, padding = 1 },
    --
    -- { section = 'startup' },
  },
}

return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    animate = {},
    bigfile = { enabled = true },
    bufdelete = { enabled = true },
    dashboard = dashboardConfig,
    gitbrowse = { enabled = true },
    indent = { enabled = true, only_current = true },
    notifier = { enabled = true, style = 'fancy' },
    rename = { enabled = true },
    words = { enabled = true },
    scroll = { enabled = true },
    input = { enabled = true },
    styles = {
      blame_line = { border = 'none' },
      notification = { border = 'rounded' },
      notification_history = { border = 'rounded' },
      input = { relative = 'cursor' },
    },
    statuscolumn = {
      enabled = true,
      left = { 'sign', 'mark' }, -- priority of signs on the left (high to low)
      right = { 'fold', 'git' }, -- priority of signs on the right (high to low)
      folds = {
        open = true,
        git_hl = true,
      },
    },
    picker = {
      sources = {
        files = {
          hidden = true,
          exclude = {},
        },
        projects = {
          -- add your own projects here in y ou wanna explicitly set them
          projects = { '~/development' },
          patterns = { '.git', '_darcs', '.hg', '.bzr', '.svn', 'package.json', 'Makefile' },
        },
      },
      layout = {
        preset = 'ivy',
        layout = {
          backdrop = 70,
        },
      },
      ui_select = true, -- replace `vim.ui.select` with the snacks picker
      win = {
        input = {
          keys = {
            ['<Esc>'] = { 'close', mode = { 'n', 'i' } },
          },
        },
      },
      icons = {
        ui = {
          ignored = ' ',
          hidden = ' ',
          follow = '󰭔 ',
        },
        git = {
          enabled = true, -- show git icons
          commit = '󰜘 ', -- used by git log
          staged = '● ', -- staged changes. always overrides the type icons
          added = ' ',
          deleted = ' ',
          ignored = ' ',
          modified = '○ ',
          renamed = '󰑕 ',
          unmerged = ' ',
          untracked = ' ',
        },
        kinds = {
          Control = ' ',
          Collapsed = ' ',
          Copilot = ' ',
          Key = ' ',
          Namespace = '󰦮 ',
          Null = ' ',
          Number = '󰎠 ',
          Object = ' ',
          Package = ' ',
          String = ' ',
          Unknown = ' ',

          -- copy from cmp
          Text = '',
          Method = '󰊕',
          Function = '󰊕',
          Constructor = '',
          Field = '󰜢',
          Variable = '',
          Class = '',
          Interface = '',
          Module = '',
          Property = '',
          Unit = '',
          Value = '',
          Enum = '',
          Keyword = '󱕴',
          Snippet = '',
          Color = '',
          File = '',
          Reference = '',
          Folder = '',
          EnumMember = '',
          Constant = '󰏿',
          Struct = '',
          Event = '',
          Operator = '',
          TypeParameter = '',
          Boolean = ' ',
          Array = ' ',
        },
      },
    },
  },
  keys = {
    {
      '<C-k>',
      ':lua Snacks.bufdelete()<CR>',
      mode = { 'n' },
      desc = 'Close current buffer',
      noremap = true,
      silent = true,
    },
    {
      '<C-S-k>',
      ':lua Snacks.bufdelete.all()<CR>',
      mode = { 'n' },
      desc = 'Close call buffers',
      noremap = true,
      silent = true,
    },
    {
      '<M-p>',
      '<cmd>lua Snacks.picker.buffers()<CR>',
      mode = { 'n' },
      desc = 'Open buffers',
      noremap = true,
      silent = true,
    },
    {
      '<leader><leader>',
      '<cmd>lua Snacks.picker.files()<CR>',
      mode = { 'n' },
      desc = 'Pick files',
      noremap = true,
      silent = true,
    },
    {
      '<leader>/',
      '<cmd>lua Snacks.picker.lines()<CR>',
      mode = { 'n' },
      desc = 'Search in current file',
      noremap = true,
      silent = true,
    },
    {
      '<leader>,',
      function()
        Snacks.picker.buffers()
      end,
      desc = 'Buffers',
    },
    {
      '<leader>fb',
      function()
        Snacks.picker.buffers()
      end,
      desc = 'Buffers',
    },
    {
      '<leader>fc',
      function()
        Snacks.picker.files { cwd = vim.fn.stdpath 'config' }
      end,
      desc = 'Find Config File',
    },
    {
      '<leader>ff',
      function()
        Snacks.picker.files()
      end,
      desc = 'Find Files',
    },
    {
      '<leader>fg',
      function()
        Snacks.picker.git_files()
      end,
      desc = 'Find Git Files',
    },
    {
      '<leader>fp',
      function()
        Snacks.picker.projects()
      end,
      desc = 'Projects',
    },
    {
      '<leader>fr',
      function()
        Snacks.picker.recent()
      end,
      desc = 'Recent',
    },
    {
      '<leader>:',
      function()
        Snacks.picker.command_history()
      end,
      desc = 'Command History',
    },
    {
      '<leader>n',
      function()
        Snacks.picker.notifications()
      end,
      desc = 'Notification History',
    },
    {
      '<leader>gb',
      '<cmd>lua Snacks.picker.git_branches()<CR>',
      mode = { 'n' },
      desc = 'Branches',
      noremap = true,
    },
    {
      '<leader>gc',
      '<cmd>lua Snacks.picker.git_log()<CR>',
      mode = { 'n' },
      desc = 'Commit Log',
      noremap = true,
    },
    {
      '<leader>gf',
      '<cmd>lua Snacks.picker.git_files()<CR>',
      mode = { 'n' },
      desc = 'Files',
      noremap = true,
    },
    {
      '<leader>gg',
      function()
        Snacks.lazygit()
      end,
      desc = 'Lazygit',
    },
    {
      '<leader>gl',
      function()
        Snacks.lazygit.log()
      end,
      desc = 'Lazygit Log (cwd)',
    },
    {
      '<leader>gs',
      '<cmd>lua Snacks.picker.git_status()<CR>',
      mode = { 'n' },
      desc = 'Status',
      noremap = true,
    },
    {
      '<leader>gt',
      '<cmd>lua Snacks.picker.git_stash()<CR>',
      mode = { 'n' },
      desc = 'Stash',
      noremap = true,
    },
    {
      '<leader>go',
      '<cmd>lua Snacks.gitbrowse()<CR>',
      mode = { 'n' },
      desc = 'Open file in remote repo',
      noremap = true,
    },
    {
      'gd',
      '<cmd>lua Snacks.picker.lsp_definitions()<CR>',
      mode = { 'n' },
      desc = 'Definitions',
      noremap = true,
    },
    {
      'gi',
      '<cmd>lua Snacks.picker.lsp_implementations()<CR>',
      mode = { 'n' },
      desc = 'Implementations',
      noremap = true,
    },
    {
      'gr',
      '<cmd>lua Snacks.picker.lsp_references()<CR>',
      mode = { 'n' },
      desc = 'References',
      noremap = true,
    },
    {
      'gs',
      '<cmd>lua Snacks.picker.lsp_symbols()<CR>',
      mode = { 'n' },
      desc = 'Document Symbols',
      noremap = true,
    },
    {
      'gt',
      '<cmd>lua Snacks.picker.lsp_type_definitions()<CR>',
      mode = { 'n' },
      desc = 'Type Definitions',
      noremap = true,
    },
    {
      '<leader>lw',
      '<cmd>lua Snacks.picker.lsp_workspace_symbols()<CR>',
      mode = { 'n' },
      desc = 'Workspace Symbols',
      noremap = true,
    },
    {
      '<leader>sg',
      '<cmd>lua Snacks.picker.grep()<CR>',
      mode = { 'n' },
      desc = 'Grep',
      noremap = true,
    },
    {
      '<leader>pl',
      '<cmd>lua Snacks.picker.grep()<CR>',
      mode = { 'n' },
      desc = 'Live Grep',
      noremap = true,
    },
    {
      '<leader>pb',
      '<cmd>lua Snacks.picker.grep_buffers()<CR>',
      mode = { 'n' },
      desc = 'Grep Buffers',
      noremap = true,
    },
    {
      '<leader>va',
      '<cmd>lua Snacks.picker.autocmds()<CR>',
      mode = { 'n' },
      desc = 'Autocommands',
      noremap = true,
    },
    {
      '<leader>vc',
      '<cmd>lua Snacks.picker.commands()<CR>',
      mode = { 'n' },
      desc = 'Commands',
      noremap = true,
    },
    {
      '<leader>ve',
      '<cmd>lua Snacks.picker.spelling()<CR>',
      mode = { 'n' },
      desc = 'Spell Suggestions',
      noremap = true,
    },
    {
      '<leader>vh',
      '<cmd>lua Snacks.picker.help()<CR>',
      mode = { 'n' },
      desc = 'Help Pages',
      noremap = true,
    },
    {
      '<leader>vb',
      '<cmd>lua Snacks.picker.command_history()<CR>',
      mode = { 'n' },
      desc = 'Command History',
      noremap = true,
    },
    {
      '<leader>vj',
      '<cmd>lua Snacks.picker.jumps()<CR>',
      mode = { 'n' },
      desc = 'Jump List',
      noremap = true,
    },
    {
      '<leader>vk',
      '<cmd>lua Snacks.picker.marks()<CR>',
      mode = { 'n' },
      desc = 'Marks',
      noremap = true,
    },
    {
      '<leader>vl',
      '<cmd>lua Snacks.picker.loclist()<CR>',
      mode = { 'n' },
      desc = 'Location List',
      noremap = true,
    },
    {
      '<leader>vm',
      '<cmd>lua Snacks.picker.man()<CR>',
      mode = { 'n' },
      desc = 'Man Pages',
      noremap = true,
    },
    {
      '<leader>vo',
      '<cmd>lua Snacks.picker.colorschemes()<CR>',
      mode = { 'n' },
      desc = 'Colorscheme',
      noremap = true,
    },
    {
      '<leader>vi',
      '<cmd>lua Snacks.picker.highlights()<CR>',
      mode = { 'n' },
      desc = 'Highlights',
      noremap = true,
    },
    {
      '<leader>vp',
      '<cmd>lua Snacks.picker.resume()<CR>',
      mode = { 'n' },
      desc = 'Resume Last Picker',
      noremap = true,
    },
    {
      '<leader>vz',
      '<cmd>lua Snacks.picker.lazy()<CR>',
      mode = { 'n' },
      desc = 'Lazy Plugins',
      noremap = true,
    },
    {
      '<leader>vq',
      '<cmd>lua Snacks.picker.qflist()<CR>',
      mode = { 'n' },
      desc = 'Quickfix List',
      noremap = true,
    },
    {
      '<leader>vr',
      '<cmd>lua Snacks.picker.registers()<CR>',
      mode = { 'n' },
      desc = 'Registers',
      noremap = true,
    },
    {
      '<leader>vs',
      '<cmd>lua Snacks.picker.search_history()<CR>',
      mode = { 'n' },
      desc = 'Search History',
      noremap = true,
    },
    {
      '<leader>vy',
      '<cmd>lua Snacks.picker.keymaps()<CR>',
      mode = { 'n' },
      desc = 'Normal Mode Keymaps',
      noremap = true,
    },
    {
      'grn',
      function()
        Snacks.words.jump(1, true)
      end,
      mode = { 'n' },
      desc = 'Go to next reference',
      silent = true,
    },
    {
      'grp',
      function()
        Snacks.words.jump(-1, true)
      end,
      mode = { 'n' },
      desc = 'Go to previous reference',
      silent = true,
    },
    {
      '<leader>vn',
      ':lua Snacks.notifier.show_history()<CR>',
      mode = { 'n' },
      desc = 'Notifications history',
      silent = true,
    },
  },
}
