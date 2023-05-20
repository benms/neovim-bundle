
![image](https://github.com/benms/neovim-bundle/assets/557984/7f1ede4c-2812-4ab1-8194-46efa312e204)

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
