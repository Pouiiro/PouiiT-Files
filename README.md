# 🦄 Pouiiro's Web Dev Dotfiles

A modern, batteries-included Neovim configuration for web development, paired with a beautiful [Alacritty](https://github.com/alacritty/alacritty) terminal setup.

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
- **Alacritty Terminal**  
  [Install Alacritty](https://github.com/alacritty/alacritty#installation)
- **Optional:** [Ripgrep](https://github.com/BurntSushi/ripgrep), [fd](https://github.com/sharkdp/fd), [fzf](https://github.com/junegunn/fzf), [lazygit](https://github.com/jesseduffield/lazygit)

### 🪟 Windows

- Use [WSL 2](https://learn.microsoft.com/en-us/windows/wsl/install) for best experience.
- Install [Nerd Font](https://www.nerdfonts.com/font-downloads) and set it in Alacritty.

### 🍏 macOS / 🐧 Linux

- Use your package manager for all dependencies.
- Example for Homebrew (macOS):
  ```sh
  brew install neovim node alacritty ripgrep fd fzf lazygit
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
   ln -s ~/.config/alacritty ~/.config/alacritty
   ```

3. **Install plugins:**

   - Open Neovim and plugins will auto-install via [lazy.nvim](https://github.com/folke/lazy.nvim).
   - **On first run, wait for Treesitter to finish installing parsers** (watch the status line).
   - Run `:Mason` to install LSP servers, formatters, and linters as needed.

4. **Set your terminal font to JetBrainsMono Nerd Font** (or another Nerd Font).

---

## ✨ Features

- ⚡ **LSP**: Autocompletion, diagnostics, code actions for JS/TS, HTML, CSS, GraphQL, Lua, etc.
- 🧹 **Formatting & Linting**: Prettier, Biome, ESLint, shfmt, etc.
- 🤖 **Copilot & Copilot Chat**: AI code suggestions and chat (with custom prompts).
- 🎨 **UI**: Tokyo Night & Catppuccin themes, Noice, Lualine, Flash, Treesitter, NvimTree, etc.
- 🌈 **Tailwind**: Color highlighting, folding, tools for Tailwind CSS.
- 📝 **Markdown**: Live preview, enhanced rendering.
- 🖥️ **Alacritty**: Transparent, themed, fast, with custom keybindings.

---

## 🎹 Common Keymaps

| Keymap            | Action                           |
| ----------------- | -------------------------------- |
| `<leader>q`       | Open diagnostic quickfix list    |
| `<C-x>`           | Show diagnostics float           |
| `<C-f>`           | Code actions (LSP)               |
| `<C-h>`           | Hover docs (LSP)                 |
| `<C-j>`           | Signature help (LSP)             |
| `<Tab>`/`<S-Tab>` | Next/previous buffer             |
| `<leader>e`       | Toggle file explorer (NvimTree)  |
| `<leader>f`       | Format buffer                    |
| `<leader>cc...`   | Copilot Chat actions (see below) |
| `<leader>s`       | Flash jump (search/jump)         |
| `<leader>S`       | Flash Treesitter jump            |
| `<leader>sn`      | Snacks: next/prev surround       |
| `<leader>sa`      | Snacks: add surround             |

### 🤖 Copilot Chat

- `<leader>ccp` — Prompt actions
- `<leader>cce` — Explain code
- `<leader>cct` — Generate tests
- `<leader>ccr` — Review code
- `<leader>ccv` — Toggle Copilot Chat (vertical split)
- `<leader>cci` — Ask Copilot (input)
- `<leader>ccm` — Generate commit message

---

## 🧑‍💻 Usage Examples

- **Run TypeScript compiler:**  
  `:TSC` or `<leader>X`
- **Show diagnostics:**  
  `<leader>x`
- **Rename variable (LSP):**  
  `<space>rn`
- **Format file:**  
  `<leader>f`
- **Open Copilot Chat:**  
  `<leader>ccv` or `<leader>ccp` for prompt actions
- **Jump to any word/char (Flash):**  
  `<leader>s` then type the target
- **Jump to syntax node (Flash Treesitter):**  
  `<leader>S` then select node
- **Toggle file explorer (NvimTree):**  
  `<leader>e`
- **Add surround (Snacks):**  
  `<leader>sa` then choose surround
- **Move to next/prev surround (Snacks):**  
  `<leader>sn`

---

## 🖥️ Alacritty

- Transparent background, Tokyo Night theme
- Font: JetBrainsMono Nerd Font
- Custom keybindings for copy/paste (Ctrl+C/V)
- See `alacritty/alacritty.toml` and `alacritty/alacritty.window.toml` for details

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
- [Alacritty Wiki](https://github.com/alacritty/alacritty/wiki)

---

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
