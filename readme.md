
![image](https://github.com/benms/neovim-bundle/assets/557984/7f1ede4c-2812-4ab1-8194-46efa312e204)

![CI Status](https://github.com/benms/neovim-bundle/actions/workflows/ci.yml/badge.svg)
![Extended Tests](https://github.com/benms/neovim-bundle/actions/workflows/test.yml/badge.svg)
[![Neovim Minimum Version](https://img.shields.io/badge/Neovim-0.8.0%2B-blueviolet.svg?style=flat-square&logo=Neovim&logoColor=white)](https://github.com/neovim/neovim)
[![Lua](https://img.shields.io/badge/Made%20with%20Lua-blue.svg?style=flat-square&logo=lua)](https://www.lua.org)

## Requirements

- [Nerd Fonts](https://www.nerdfonts.com/font-downloads) (Optional with manual intervention: See [Recipes/Customizing Icons](https://astronvim.com/Recipes/icons#disable-icons))
- [Neovim v0.8+ (Not including nightly)](https://github.com/neovim/neovim/releases/tag/stable)
zTree-sitter CLI (Note: This is only necessary if you want to use auto_install feature with Treesitter)
- A clipboard tool is necessary for the integration with the system clipboard (see :help clipboard-tool for supported solutions)
- Terminal with true color support (for the default theme, otherwise it is dependent on the theme you are using)
- Optional Requirements:
    - [ripgrep](https://github.com/BurntSushi/ripgrep) - live grep telescope search (<leader>fw)
    - [lazygit](https://github.com/jesseduffield/lazygit) - git ui toggle terminal (<leader>tl or <leader>gg)
    - Python - python repl toggle terminal (<leader>tp)
    - Node - Node is needed for a lot of the LSPs, and for the node repl toggle terminal (<leader>tn)
    - `vim.opt.shell` should be set to your current shell in system


## Instalation

Make a backup of your current nvim folder

`mv ~/.config/nvim ~/.config/nvim.bak`

Clean neovim folders (Optional but recommended)

```
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak
```

Clone the repository

`git clone --depth 1 https://github.com/benms/neovim-bundle ~/.config/nvim`

## Testing

This configuration includes automated testing to ensure reliability across different platforms.

### Continuous Integration

The repository uses GitHub Actions to automatically test the configuration on:
- **Linux** (Ubuntu latest) - with Neovim stable and nightly
- **macOS** (latest)
- **Windows** (latest)

Tests include:
- Configuration loading verification
- Plugin installation checks
- LSP setup validation
- Syntax validation for all Lua files
- Health check analysis
- Performance benchmarking

### Running Tests Locally

You can run the test suite locally to verify your configuration:

```bash
# Run all tests
./test/run_tests.sh

# The test script will check:
# - Neovim version compatibility
# - Required dependencies
# - File structure integrity
# - Configuration loading
# - Plugin installation
# - LSP functionality
# - Lua syntax validity
# - Common issues (tabs, trailing whitespace)
# - Health check status
# - Startup performance
```

The test results will be displayed with color-coded output:
- ✓ Green: Test passed
- ✗ Red: Test failed
- ⚠ Yellow: Warning (non-critical issue)

### Manual Testing

You can also manually test specific aspects:

```bash
# Check configuration loads without errors
nvim --headless -c "echo 'Config OK'" -c "qa"

# Run health check
nvim --headless -c "checkhealth" -c "qa"

# Sync plugins
nvim --headless -c "Lazy! sync" -c "qa"

# Check for Lua syntax errors
find . -name "*.lua" -exec luac -p {} \;
```

## Plugins/Modules Used

### Plugin Manager
- [lazy.nvim](https://github.com/folke/lazy.nvim) - Modern plugin manager for Neovim

### Core Plugins
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - Syntax highlighting and code parsing
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - Quickstart configurations for the Neovim LSP client
- [mason.nvim](https://github.com/williamboman/mason.nvim) - Portable package manager for Neovim (LSP servers, DAP servers, linters, formatters)

### Completion
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) - Completion engine
- [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp) - LSP source for nvim-cmp
- [cmp-buffer](https://github.com/hrsh7th/cmp-buffer) - Buffer source for nvim-cmp
- [cmp-path](https://github.com/hrsh7th/cmp-path) - Path source for nvim-cmp
- [cmp-cmdline](https://github.com/hrsh7th/cmp-cmdline) - Command line source for nvim-cmp

### Navigation & Search
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) - Fuzzy finder and picker
- [hop.nvim](https://github.com/phaazon/hop.nvim) - Neovim motions on speed
- [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) - File explorer

### Git Integration
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) - Git decorations and hunks

### UI Enhancements
- [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) - Fast and easy statusline
- [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) - Snazzy buffer line
- [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) - File icons
- [onedark.vim](https://github.com/joshdick/onedark.vim) - OneDark color scheme

### Utilities
- [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) - Terminal integration
- [none-ls.nvim](https://github.com/nvimtools/none-ls.nvim) - Use Neovim as a language server (formatting, diagnostics)
- [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) - Lua utility functions (dependency for many plugins)
- [nui.nvim](https://github.com/MunifTanjim/nui.nvim) - UI component library (dependency for neo-tree)
- [lsp-progress.nvim](https://github.com/linrongbin16/lsp-progress.nvim) - LSP progress indicator

## Keyboard Shortcuts

### General Navigation
- `<leader>` - Space key (default leader)

### File Navigation (Telescope)
- `<leader>ff` - Find files
- `<leader>fw` - Live grep (search in files)
- `<leader>fb` - Browse buffers
- `<leader>fh` - Help tags
- `*` - Search for word under cursor
- `<leader>ls` - List document symbols

### Git Integration
- `<leader>gb` - Git branches
- `<leader>gc` - Git commits
- `<leader>gs` - Git status
- `<leader>gf` - Git files
- `<leader>gg` - Open lazygit (if installed)

### LSP (Language Server Protocol)
- `gd` - Go to definition
- `gr` - Go to references
- `gD` - Go to declaration
- `K` - Hover documentation
- `gi` - Go to implementation
- `<C-k>` - Signature help
- `<leader>wa` - Add workspace folder
- `<leader>wr` - Remove workspace folder
- `<leader>wl` - List workspace folders
- `<leader>lr` - Rename symbol
- `<leader>la` - Code actions
- `<leader>lf` - Format code
- `[d` - Go to previous diagnostic
- `]d` - Go to next diagnostic
- `<leader>e` - Show diagnostic float
- `<leader>q` - Show diagnostics list

### Hop Navigation
- `f` - Hop to character forward (current line)
- `F` - Hop to character backward (current line)
- `t` - Hop till character forward (current line)
- `T` - Hop till character backward (current line)
- `<leader>hw` - Hop to word
- `<leader>hl` - Hop to line
- `<leader>hp` - Hop to pattern
- `<leader>ha` - Hop anywhere
- `<leader>hc` - Hop to 2 characters

### Autocompletion (nvim-cmp)
- `<C-b>` - Scroll docs up
- `<C-f>` - Scroll docs down
- `<C-Space>` - Trigger completion
- `<C-e>` - Abort completion
- `<CR>` - Confirm selection
- `<Tab>` - Next completion item
- `<S-Tab>` - Previous completion item

### Terminal (ToggleTerm)
- `<C-\>` - Toggle terminal
- `<leader>tl` - Open lazygit terminal
- `<leader>tp` - Open Python REPL
- `<leader>tn` - Open Node REPL
- **In terminal mode:**
  - `<Esc>` or `jk` - Exit terminal mode
  - `<C-h/j/k/l>` - Navigate between windows
  - `<C-w>` - Window commands

### Buffer Management
- Navigate between buffers using bufferline (mouse click or keyboard shortcuts can be configured)

### Neo-tree File Explorer
- Can be toggled and navigated (default keybindings apply when focused)

### Custom Mappings
- `jj` - Exit insert mode (mapped to `<Esc>`)
- `:W` - Save file (alias for `:w`)
