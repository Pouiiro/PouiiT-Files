-- NOTE: nixCats: this is where we define some arguments for the lazy wrapper.
local pluginList = nil
local nixLazyPath = nil
if require('nixCatsUtils').isNixCats then
  local allPlugins = require("nixCats").pawsible.allPlugins
  -- it is called pluginList because we only need to pass in the names
  -- this list literally just tells lazy.nvim not to download the plugins in the list.
  pluginList = require('nixCatsUtils.lazyCat').mergePluginTables( allPlugins.start, allPlugins.opt)

  -- it wasnt detecting that these were already added
  -- because the names are slightly different from the url.
  -- when that happens, add them to the list, then also specify the new name in the lazySpec
  pluginList[ [[Comment.nvim]] ] = ""
  pluginList[ [[LuaSnip]] ] = ""
  -- alternatively you can do it all in the plugins spec instead of modifying this list.
  -- just set the name and then add `dev = require('nixCatsUtils').lazyAdd(false, true)` to the spec

  -- HINT: to view the names of all plugins downloaded via nix, use the `:NixCats pawsible` command.

  -- we also want to pass in lazy.nvim's path
  -- so that the wrapper can add it to the runtime path
  -- as the normal lazy installation instructions dictate
  nixLazyPath = allPlugins.start[ [[lazy.nvim]] ]
end
-- NOTE: nixCats: You might want to move the lazy-lock.json file
local function getlockfilepath()
  if require('nixCatsUtils').isNixCats and type(require('nixCats').settings.unwrappedCfgPath) == "string" then
    return require('nixCats').settings.unwrappedCfgPath .. "/lazy-lock.json"
  else
    return vim.fn.stdpath("config") .. "/lazy-lock.json"
  end
end
local lazyOptions = {
  lockfile = getlockfilepath(),
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
}
