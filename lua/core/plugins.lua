local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ 'phaazon/hop.nvim' },
    { 'nvim-treesitter/nvim-treesitter' },
    { 'neovim/nvim-lspconfig' },
    { 'joshdick/onedark.vim' },
    { 'hrsh7th/cmp-nvim-lsp' }, { 'hrsh7th/cmp-buffer' }, { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-cmdline' }, { 'hrsh7th/nvim-cmp' },
    { "williamboman/mason.nvim", build = ":MasonUpdate" },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.1',
        dependencies = {'nvim-lua/plenary.nvim'}
    },
    { 'jose-elias-alvarez/null-ls.nvim' },
    { 'lewis6991/gitsigns.nvim' },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons', 'linrongbin16/lsp-progress.nvim'
        }
    },
    {"akinsho/bufferline.nvim", dependencies = {'nvim-tree/nvim-web-devicons'}},
    {'ThePrimeagen/harpoon'},
    { "lukas-reineke/indent-blankline.nvim" },
});
