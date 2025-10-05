return {
  "Tsuzat/NeoSolarized.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    local neosolarized = require("NeoSolarized")

    neosolarized.setup({
      style = "dark", -- "dark" or "light"
      transparent = true, -- true/false; Enable this to disable setting the background color
      terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
      enable_italics = true, -- Italics for different hightlight groups (eg. Statement, Condition, Comment, Include, etc.)
      styles = {
        -- Style to be applied to different syntax groups
        comments = { italic = true },
        keywords = { italic = true },
        functions = { bold = true },
        variables = {},
        string = { italic = true },
        underline = true, -- true/false; for global underline
        undercurl = false, -- true/false; for global undercurl
      },
      -- Add specific hightlight groups
      on_highlights = function(highlights, colors)
        highlights.Include.fg = colors.red -- Using `red` foreground for Includes
      end,
    })
    vim.cmd("colorscheme NeoSolarized")

    local colors = require("NeoSolarized.colors").setup({ style = "dark" })

    -- Diagnostics (using theme colors)
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = colors.red })
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = colors.orange }) -- less bright than yellow
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { undercurl = true, sp = colors.cyan })
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { undercurl = true, sp = colors.green })
    vim.api.nvim_set_hl(0, "RenderMarkdownCode", { bg = "#211d3d" })
  end,
}
