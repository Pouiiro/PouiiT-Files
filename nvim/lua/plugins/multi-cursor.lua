return {
  "jake-stewart/multicursor.nvim",
  lazy = false,
  config = function()
    local mc = require("multicursor-nvim")
    mc.setup()

    local set = vim.keymap.set

    -- Add or skip cursor above/below the main cursor.
    set({ "n", "x" }, "<leader>m<up>", function()
      mc.lineAddCursor(-1)
    end)
    set({ "n", "x" }, "<leader>m<down>", function()
      mc.lineAddCursor(1)
    end)
    set({ "n", "x" }, "<leader>ms<up>", function()
      mc.lineSkipCursor(-1)
    end)
    set({ "n", "x" }, "<leader>ms<down>", function()
      mc.lineSkipCursor(1)
    end)

    -- Add or skip adding a new cursor by matching word/selection
    set({ "n", "x" }, "<leader>mn", function()
      mc.matchAddCursor(1)
    end)
    set({ "n", "x" }, "<leader>mp", function()
      mc.matchSkipCursor(1)
    end)
    set({ "n", "x" }, "<leader>msp", function()
      mc.matchAddCursor(-1)
    end)
    set({ "n", "x" }, "<leader>msn", function()
      mc.matchSkipCursor(-1)
    end)

    -- Disable and enable cursors.
    set({ "n", "x" }, "<c-q>", mc.toggleCursor)

    -- Mappings defined in a keymap layer only apply when there are
    -- multiple cursors. This lets you have overlapping mappings.
    mc.addKeymapLayer(function(layerSet)
      -- Enable and clear cursors using escape.
      layerSet("n", "<esc>", function()
        if not mc.cursorsEnabled() then
          mc.enableCursors()
        else
          mc.clearCursors()
        end
      end)
    end)

    -- Customize how cursors look.
    local hl = vim.api.nvim_set_hl
    hl(0, "MultiCursorCursor", { reverse = true })
    hl(0, "MultiCursorVisual", { link = "Visual" })
    hl(0, "MultiCursorSign", { link = "SignColumn" })
    hl(0, "MultiCursorMatchPreview", { link = "Search" })
    hl(0, "MultiCursorDisabledCursor", { reverse = true })
    hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
    hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
  end,
}
