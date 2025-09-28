# ☕ Pouiiro's Web Dev Dotfiles

Modern, batteries-included Neovim configuration for web development, paired with a beautiful [Kitty](https://sw.kovidgoyal.net/kitty/) terminal setup and macOS window management tools.

> **✨ Fast, modular, and designed for productivity!**

---

## 🚀 Prerequisites

- **Neovim 0.11+**  
  [Install Neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim)
- **Node.js (v18+)**  
  [Install Node.js](https://nodejs.org/en/download/)
- **Rust nightly** (for some plugins)  
  [Install Rust](https://rustup.rs/)
- **Nerd Font** (e.g. [JetBrainsMono Nerd Font](https://www.nerdfonts.com/font-downloads))
- **Kitty Terminal**  
  [Install Kitty](https://sw.kovidgoyal.net/kitty/#installation)
- **macOS:** [yabai](https://github.com/koekeishiya/yabai), [skhd](https://github.com/koekeishiya/skhd) for window management
- **Optional:** [Ripgrep](https://github.com/BurntSushi/ripgrep), [fd](https://github.com/sharkdp/fd), [fzf](https://github.com/junegunn/fzf), [lazygit](https://github.com/jesseduffield/lazygit)

### 🪟 Windows

- Use [WSL 2](https://learn.microsoft.com/en-us/windows/wsl/install) for best experience.
- Install [Nerd Font](https://www.nerdfonts.com/font-downloads) and set it in Alacritty.

### 🍏 macOS / 🐧 Linux

- Use your package manager for all dependencies.
- Example for Homebrew (macOS):
  ```sh
  brew install neovim node kitty gh ripgrep fd fzf lazygit yabai skhd
  ```
- Follow instructions, make sure to install Nightly
  ```sh
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  ```

---

## 🛠️ Installation

1. **Clone this repo:**

   ```sh
   git clone https://github.com/Pouiiro/PouiiT-Files ~/.config
   ```

2. **Symlink or copy the configs:**

   ```sh
   ln -s ~/.config/nvim ~/.config/nvim
   ln -s ~/.config/kitty ~/.config/kitty
   ```

3. **Install plugins:**

   - Open Neovim and plugins will auto-install via [lazy.nvim](https://github.com/folke/lazy.nvim).
   - **On first run, wait for Treesitter to finish installing parsers** (watch the status line).
   - Run `:Mason` to install LSP servers, formatters, and linters as needed.

4. **Set your terminal font to JetBrainsMono Nerd Font** (or another Nerd Font).

---

## ✨ Features

- ⚡ **LSP**: Autocompletion, diagnostics, code actions for JS/TS, HTML, CSS, GraphQL, Lua, etc.
- 🧹 **Formatting & Linting**: Biome, Prettier, shfmt, etc.
- 🤖 **Copilot & CodeCompanion**: AI code suggestions and chat (with custom prompts).
- 🎨 **UI**: Tokyo Night, Catppuccin, NeoSolarized themes, Noice, Lualine, Flash, Treesitter, NvimTree, Snacks, etc.
- 🌈 **Tailwind**: Color highlighting, folding, tools for Tailwind CSS.
- 📝 **Markdown**: Live preview, enhanced rendering.
- 🖥️ **Kitty**: Transparent, themed, fast, with custom keybindings.
- 🍏 **macOS Window Management**: Yabai (tiling), skhd (hotkeys)

---



## 🎹 Custom Keymaps

All keymaps are defined in `nvim/lua/config/keymaps.lua` and grouped below for easy reference.

### Buffer & Navigation
| Keymap                | Action                                 |
|-----------------------|----------------------------------------|
| `<Tab>` / `<S-Tab>`   | Next/previous buffer                   |
| `<C-b>`               | Show buffer picker (Snacks)            |
| `<C-k>`               | Close buffer                           |
| `<leader>sa`          | Snacks: all pickers                    |
| `<leader>sf`          | Terminal selector                      |

### Window Management
| Keymap                | Action                                 |
|-----------------------|----------------------------------------|
| `ss`                  | Horizontal split                       |
| `sv`                  | Vertical split                         |
| `sc`                  | Close split                            |
| `<C-'>`               | Resize window left                     |
| `<C-ö>`               | Resize window right                    |
| `<C-ä>`               | Resize window up                       |
| `<C-å>`               | Resize window down                     |

### Editing & Selection
| Keymap                | Action                                 |
|-----------------------|----------------------------------------|
| `<C-a>`               | Select all                             |
| `<C-e>` (insert)      | Move to end of line in insert mode     |
| `<C-i>` (insert)      | Move to start of line in insert mode   |

### LSP & Diagnostics
| Keymap                | Action                                 |
|-----------------------|----------------------------------------|
| `<C-x>`               | Show diagnostics float                 |
| `<C-f>`               | Code actions (LSP)                     |
| `<C-h>`               | Hover docs (LSP)                       |
| `<C-j>`               | Signature help (LSP)                   |
| `<C-,>`               | Go to next diagnostic                  |
| `<C-m>`               | Go to previous diagnostic              |
| `<C-vr>`              | Rename variable (LSP)                  |

### AI & Copilot
| Keymap                | Action                                 |
|-----------------------|----------------------------------------|
| `<C-n>` (insert)      | Next Copilot suggestion                |
| `<C-y>` (insert/cmd)  | Accept Copilot suggestion              |
| `<leader>ca`          | CodeCompanion chat/actions             |
| `<leader>cA`          | CodeCompanion actions palette          |
| `<leader>cc...`       | Copilot Chat actions (see below)       |

### Snacks & Testing
| Keymap                | Action                                 |
|-----------------------|----------------------------------------|
| `<leader>twf`         | Run Vitest watch (file)                |
| `<leader>twr`         | Run Vitest watch (project)             |

### TypeScript Tools
| Keymap                | Action                                 |
|-----------------------|----------------------------------------|
| `<leader>tu`          | Remove unused imports                  |
| `<leader>tv`          | Remove unused variables                |
| `<leader>ti`          | Add missing imports                    |
| `<leader>tr`          | Rename file                            |

---

## 🚀 Quick Start

Clone and run the setup script to install everything:

```sh
git clone https://github.com/Pouiiro/PouiiT-Files ~/.config
cd ~/.config
chmod +x setup.sh
./setup.sh
```

This will:
- Install all dependencies (Neovim, Kitty, Node.js, etc.)
- Symlink configs for Neovim, Kitty, yabai, skhd
- Set up AI allowed directories
- Guide you to set your terminal font

Open Kitty and run `nvim` to start!

### 🤖 CodeCompanion

- `<leader>ca` — Open CodeCompanion chat/actions
- `<leader>cA` — Open CodeCompanion actions palette

---

## 🧑‍💻 Usage Examples

- **Show diagnostics:**  
  `<leader>x`
- **Jump to any word/char (Flash):**  
  `s` then type the target
- **Jump to syntax node (Flash Treesitter):**  
  `S` then select node
- **Toggle file explorer:**  
  `<leader>e`

---

## 🤖 AI Directory Control

By default, AI features (Copilot, CodeCompanion) are only enabled in public or allowed directories. To customize where AI is available, set the environment variable `NVIM_AI_ALLOWED_PATHS`:

```sh
export NVIM_AI_ALLOWED_PATHS="~/dev,~/projects,~/dotfiles"
```

This variable should be a comma-separated list of absolute or `~`-epanded paths. Only files inside these directories will have AI features enabled. See `lua/utils/copilot-private.lua` for details.

---

## 🖥️ Kitty Terminal

- Transparent background, Tokyo Night, Gruvbox, NeoSolarized, Kanagawa themes
- Font: JetBrainsMono Nerd Font
- Custom keybindings for copy/paste (Ctrl+C/V)
- See `kitty/*.conf` for details

## 🍏 macOS Window Management

- **Yabai**: Tiling window manager for macOS
- **skhd**: Hotkey daemon for window management
- See `yabai/yabairc` and `skhd/skhdrc` for configs

---

## 📝 Tips for New Neovim Users

- 🚦 **Wait for Treesitter** to finish installing on first launch!
- 🧩 Use `:Mason` to install/manage LSP servers and tools.
- 📚 Use `:Tutor` to learn basic Vim/Neovim motions.
- 🔍 Use `<space>sh` to search Neovim help.
- 🧑‍🔧 Explore `:Lazy` for plugin management.
- 🛠️ Check `lua/keymaps.lua` for all custom keymaps.
- 🩺 For troubleshooting, use `:checkhealth`.

---

## 📦 Updating Plugins

- Open Neovim and run:
  ```
  :Lazy update
  ```

---

## 🤝 Contributing

Feel free to fork and adapt for your own workflow! PRs and suggestions welcome.

---

## 📚 Resources

- [Neovim Docs](https://neovim.io/doc/)
- [Kitty Documentation](https://sw.kovidgoyal.net/kitty/)

---

## 🧩 Extras

### 🍏 macOS: Karabiner Elements

- Use [Karabiner Elements](https://karabiner-elements.pqrs.org/) to remap your CapsLock key:
  - **CapsLock** → **Esc** (when pressed alone)
  - **CapsLock** → **Ctrl** (when held with another key)
  - **CapsLock** → **CapsLock** (when pressed with Shift)
- The config is included: [`karabiner/karabiner.json`](karabiner/karabiner.json)

### 🪟 Windows: AutoHotkey

- Use [AutoHotkey](https://www.autohotkey.com/) to get similar keybindings.
- Script included: [`autohotkey/nvim_bindings.ahk`](autohotkey/nvim_bindings.ahk)

---
