return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons', 'AndreM222/copilot-lualine', 'f-person/git-blame.nvim' },
  event = 'VeryLazy',
  config = function()
    local colors = {
      bg = '#000000',
      fg = '#bbc2cf',
      yellow = '#ECBE7B',
      cyan = '#008080',
      darkblue = '#081633',
      green = '#98be65',
      orange = '#FF8800',
      violet = '#a9a1e1',
      magenta = '#c678dd',
      blue = '#51afef',
      red = '#ec5f67',
    }

    local lualine = require 'lualine'
    local git_blame = require 'gitblame'
    local icons = require 'nvim-web-devicons'

    vim.g.gitblame_display_virtual_text = 0

    local function get_filetype_icon(filetype)
      -- Use nvim-web-devicons to get the file type icon
      local icon, _ = icons.get_icon(filetype, nil, { default = true })

      -- If no icon is found, fall back to a generic file icon
      if not icon then
        icon = '' -- Generic file icon
      end

      -- Specific mapping for common JavaScript/TypeScript filetypes (use Nerd Fonts icons)
      if filetype == 'javascript' then
        icon = '' -- JavaScript icon
      elseif filetype == 'typescript' then
        icon = '' -- TypeScript icon
      elseif filetype == 'javascriptreact' then
        icon = '' -- JSX icon
      elseif filetype == 'typescriptreact' then
        icon = '' -- TSX icon
      end

      return icon
    end

    local function getBlame()
      if git_blame.get_current_blame_text() == nil then
        return [[LazyPouiiro Zzz]]
      end
      return git_blame.get_current_blame_text()
    end

    local conditions = {
      buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand '%:t') ~= 1
      end,
      hide_in_width = function()
        return vim.fn.winwidth(0) > 80
      end,
      check_git_workspace = function()
        local filepath = vim.fn.expand '%:p:h'
        local gitdir = vim.fn.finddir('.git', filepath .. ';')
        return gitdir and #gitdir > 0 and #gitdir < #filepath
      end,
    }

    -- Config
    local config = {
      options = {
        -- Disable sections and component separators
        component_separators = '',
        icons_enabled = true,
        always_divide_middle = true,
        section_separators = '',
        globalstatus = true,
        -- theme = "dracula-nvim",
        theme = {

          -- We are going to use lualine_c an lualine_x as left and
          -- right section. Both are highlighted by c theme .  So we
          -- are just setting default looks o statusline
          normal = { c = { fg = colors.fg, bg = colors.bg } },
          inactive = { c = { fg = colors.fg, bg = colors.bg } },
        },
      },
      sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        -- These will be filled later
        lualine_c = {},
        lualine_x = {},
      },
      inactive_sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
      },
    }

    -- Inserts a component in lualine_c at left section
    local function ins_left(component)
      table.insert(config.sections.lualine_c, component)
    end

    -- Inserts a component in lualine_x at right section
    local function ins_right(component)
      table.insert(config.sections.lualine_x, component)
    end

    local function is_active()
      local ok, hydra = pcall(require, 'hydra.statusline')
      return ok and hydra.is_active()
    end

    local function get_name()
      local ok, hydra = pcall(require, 'hydra.statusline')
      if ok then
        return hydra.get_name()
      end
      return ''
    end

    -- ins_left {
    --   function()
    --     return '▊'
    --   end,
    --   color = { fg = colors.blue }, -- Sets highlighting of component
    --   padding = { left = 0, right = 1 }, -- We don't need space before this
    -- }

    ins_left {
      -- mode component
      function()
        local m = vim.api.nvim_get_mode().mode
        return '  ' .. ' ' .. m.upper(m) .. ''
        -- return "  "
      end,
      color = function()
        -- auto change color according to neovims mode
        local mode_color = {
          n = colors.red,
          i = colors.green,
          v = colors.blue,
          [''] = colors.blue,
          V = colors.blue,
          c = colors.magenta,
          no = colors.red,
          s = colors.orange,
          S = colors.orange,
          [''] = colors.orange,
          ic = colors.yellow,
          R = colors.violet,
          Rv = colors.violet,
          cv = colors.red,
          ce = colors.red,
          r = colors.cyan,
          rm = colors.cyan,
          ['r?'] = colors.cyan,
          ['!'] = colors.red,
          t = colors.red,
        }
        return { fg = mode_color[vim.fn.mode()] }
      end,
      padding = { right = 1 },
    }
    --
    -- ins_left {
    --   -- filesize component
    --   'filesize',
    --   cond = conditions.buffer_not_empty,
    -- }

    ins_left {
      function()
        -- Get the filetype of the current buffer
        local filetype = vim.bo.filetype
        -- Retrieve the correct icon for the file type
        local icon = get_filetype_icon(filetype)

        -- Return the icon and the filename
        return icon .. ' ' .. vim.fn.expand '%:t' -- %:t gives the filename
      end,
      cond = function()
        local buff = vim.fn.bufname()
        return conditions.buffer_not_empty() and vim.bo.filetype ~= 'NvimTree' and not buff:find '/scratch/'
      end,
      color = { fg = colors.yellow, gui = 'bold' },
    }

    -- ins_left { "location" }

    -- ins_left { 'progress', color = { fg = colors.fg, gui = 'bold' } }
    ins_left {
      'copilot',
      -- Default values
      symbols = {
        status = {
          icons = {
            enabled = ' ',
            sleep = ' ', -- auto-trigger disabled
            disabled = ' ',
            warning = ' ',
            unknown = ' ',
          },
          hl = {
            enabled = '#50FA7B',
            sleep = '#50FA7B',
            disabled = '#6272A4',
            warning = '#FFB86C',
            unknown = '#FF5555',
          },
        },
        spinners = require('copilot-lualine.spinners').dots,
        spinner_color = '#6272A4',
      },
      show_colors = true,
      show_loading = true,
    }

    ins_left {
      'diagnostics',
      sources = { 'nvim_diagnostic' },
      symbols = { error = '  ', warn = '  ', info = '  ' },
      diagnostics_color = {
        error = { fg = colors.red },
        warn = { fg = colors.yellow },
        info = { fg = colors.cyan },
      },
    }

    ins_left {
      function()
        local msg = 'No Active Lsp'
        local buf_ft = vim.bo.filetype
        local clients = vim.lsp.get_clients { bufnr = 0 }
        if next(clients) == nil then
          return msg
        end

        local client_icons = {
          ['typescript-tools'] = ' ',
          ['graphql'] = ' ',
          ['eslint'] = ' ',
          ['eslint_d'] = ' ',
          ['lua_ls'] = ' ',
          ['jsonls'] = ' ',
          ['null-ls'] = ' ',
          ['html'] = ' ',
          ['cssls'] = ' ',
          ['tailwindcss'] = ' ',
          ['bashls'] = ' ',
          ['dockerls'] = ' ',
          ['yamlls'] = ' ',
          ['vimls'] = ' ',
          ['pyright'] = ' ',
          ['gopls'] = ' ',
          ['rust_analyzer'] = ' ',
          ['clangd'] = 'ﭱ ',
          ['biome'] = ' ',
          ['prismals'] = ' ',
          ['svelte'] = ' ',
          ['angularls'] = ' ',
          ['marksman'] = '󰦨 ',
          ['zk'] = '󰅴 ',
          -- Add any additional LSPs here
        }

        local client_colors = {
          ['typescript-tools'] = '#3178c6',
          ['graphql'] = '#e535ab',
          ['eslint'] = '#4b32c3',
          ['eslint_d'] = '#4b32c3',
          ['lua_ls'] = '#000080',
          ['jsonls'] = '#cbcb41',
          ['null-ls'] = '#4b32c3',
          ['html'] = '#e34c26',
          ['cssls'] = '#264de4',
          ['tailwindcss'] = '#38bdf8',
          ['bashls'] = '#89e051',
          ['dockerls'] = '#2496ed',
          ['yamlls'] = '#cbcb41',
          ['vimls'] = '#019833',
          ['pyright'] = '#3572A5',
          ['gopls'] = '#00ADD8',
          ['rust_analyzer'] = '#dea584',
          ['clangd'] = '#555555',
          ['biome'] = '#8bc34a',
          ['prismals'] = '#d75f00',
          ['svelte'] = '#ff3e00',
          ['angularls'] = '#dd0031',
          ['marksman'] = '#519aba',
          ['zk'] = '#f5c518',
          -- Add more color mappings as needed
        }

        local client_display = {}
        local defined_highlights = {}

        for _, client in ipairs(clients) do
          local client_name = client.name == 'null-ls' and 'eslint' or client.name
          local filetypes = client.config.filetypes
          if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            local icon = client_icons[client_name] or client_name
            local color = client_colors[client_name] or '#ffffff'
            local highlight_group = 'Lsp' .. client_name

            if not defined_highlights[highlight_group] then
              vim.api.nvim_set_hl(0, highlight_group, { fg = color, bg = '#000000' })

              defined_highlights[highlight_group] = true
            end

            table.insert(client_display, '%#' .. highlight_group .. '#' .. icon)
          end
        end

        if #client_display == 0 then
          return msg
        else
          return table.concat(client_display, ' ')
        end
      end,
      icon = '  ->',
      color = { fg = '#ffffff', gui = 'bold', bg = '#000000' },
    }

    -- Insert mid section. You can make any number of sections in neovim :)
    -- -- for lualine it's any number greater then 2
    -- ins_left {
    --   function()
    --     return '%='
    --   end,
    -- }
    --
    -- Add components to right sections
    ins_right {
      function()
        return getBlame()
      end,
      color = { fg = colors.blue }, -- Sets highlighting of component
      padding = { left = 0, right = 1 }, -- We don't need space before this
    }

    -- ins_right {
    --   'o:encoding', -- option component same as &encoding in viml
    --   fmt = string.upper, -- I'm not sure why it's upper case either ;)
    --   cond = conditions.hide_in_width,
    --   color = { fg = colors.green, gui = 'bold' },
    -- }
    --
    --
    ins_right { get_name, cond = is_active }
    -- ins_right {
    --   'fileformat',
    --   fmt = string.upper,
    --   icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
    --   color = { fg = colors.green, gui = 'bold' },
    -- }

    ins_right {
      'branch',
      icon = '',
      color = { fg = colors.violet, gui = 'bold' },
    }

    -- ins_right {
    --   'diff',
    --   -- Is it me or the symbol for modified us really weird
    --   symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
    --   diff_color = {
    --     added = { fg = colors.green },
    --     modified = { fg = colors.orange },
    --     removed = { fg = colors.red },
    --   },
    --   cond = conditions.hide_in_width,
    -- }

    -- ins_right {
    --   function()
    --     return '▊'
    --   end,
    --   color = { fg = colors.blue },
    --   padding = { left = 1 },
    -- }

    -- Now don't forget to initialize lualine
    lualine.setup(config)
  end,
}
