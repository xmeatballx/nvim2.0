-- Set <space> as the leader key
vim.g.mapleader = ' '

-- Set to true if you have a Nerd Font installed
vim.g.have_nerd_font = true

-- [[ Setting options ]]
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.showmode = false
vim.diagnostic.config({ update_in_insert = true })
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Clipboard sync between OS and Neovim
vim.opt.clipboard = 'unnamedplus'
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.inccommand = 'split'
vim.opt.scrolloff = 10

-- Keymaps
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, {})
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, {})
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, {})
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, {})
vim.keymap.set('n', '<leader>e', '<Cmd> :Neotree toggle<CR>', {})
vim.keymap.set('n', '<S-l>', '<CMD>BufferLineCycleNext<CR>')
vim.keymap.set('n', '<S-h>', '<CMD>BufferLineCyclePrev<CR>')

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

local is_mac = vim.fn.has("macunix") == 1

if is_mac then
  -- Lazy.nvim setup for macOS
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

  require('lazy').setup({
    -- Telescope
    { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    { "nvim-neo-tree/neo-tree.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
    -- Bufferline
    { "akinsho/bufferline.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },
    -- Comment
    { "numToStr/Comment.nvim" },
    -- Language Servers
    { "neovim/nvim-lspconfig" },
    -- Treesitter
    { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" },
    -- Completion
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "saadparwaiz1/cmp_luasnip" },
    { "L3MON4D3/LuaSnip" },
    { "rafamadriz/friendly-snippets" },
    -- LSP Configs
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    -- Indent Blankline
    { "lukas-reineke/indent-blankline.nvim" },
    -- Catppuccin theme
    { "catppuccin/nvim", name = "catppuccin" },
    -- Additional plugins
    { "tpope/vim-surround" },
    { "tpope/vim-commentary" },
    { "tpope/vim-repeat" },
    { "tpope/vim-fugitive" },
    -- Add other plugins here
  })
end
