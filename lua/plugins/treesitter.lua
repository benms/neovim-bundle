require'nvim-treesitter.configs'.setup {
  ensure_installed = { "typescript", "lua", "go", "tsx", "javascript", "vim", "vimdoc", "query" },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
  },
}
