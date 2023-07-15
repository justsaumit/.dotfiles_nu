local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save (:w) the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out!
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

--Actual good stuff
--Install all your plugins here
return packer.startup(function(use)
--Necessities
    use "wbthomason/packer.nvim"   -- Have packer manage itself
    use "nvim-lua/popup.nvim"      -- An implementation of the Popup API from vim in Neovim
    use "nvim-lua/plenary.nvim"    -- Useful lua functions used ny lots of plugins
    use "ethanholz/nvim-lastplace" -- Preserve last editing position in nvim
--TreeSitter
    use {'nvim-treesitter/nvim-treesitter',run = ':TSUpdate'}
--ColorSchemes
    use "folke/tokyonight.nvim"
    use "tiagovla/tokyodark.nvim"
    use { "catppuccin/nvim", as = "catppuccin" }
    use { 'AlphaTechnolog/pywal.nvim', as = 'pywal' }
--Web-devicons
    use "kyazdani42/nvim-web-devicons"
--Lualine
    use {'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true }}
--Bufferline
    use {'akinsho/bufferline.nvim', tag = "v2.*", requires = 'nvim-tree/nvim-web-devicons'}
--Nvim-tree File explorer for nvim
    use {'nvim-tree/nvim-tree.lua',  requires = { 'nvim-tree/nvim-web-devicons'}}
--Which-key - displays a popup with possible key bindings
    use 'folke/which-key.nvim'
--Mason-nvim Portable Package manager for LSP and DAP servers, linters and formatters
    use { "williamboman/mason.nvim", run = ":MasonUpdate"} -- :MasonUpdate updates registry contents
--lsp
    use("williamboman/mason-lspconfig.nvim")
    use("neovim/nvim-lspconfig") --> Collection of configurations for built-in LSP client
    use("jose-elias-alvarez/null-ls.nvim") --> inject lsp diagnistocs, formattings, code actions, and more ...
    use("tami5/lspsaga.nvim") --> icons for LSP diagnostics
    use("onsails/lspkind-nvim") --> vscode-like pictograms for neovim lsp completion items
    use("hrsh7th/nvim-cmp") --> Autocompletion plugin
    use("hrsh7th/cmp-nvim-lsp") --> LSP source for nvim-cmp
    use("saadparwaiz1/cmp_luasnip") --> Snippets source for nvim-cmp
    use("L3MON4D3/LuaSnip") --> Snippets plugin
--HTML
--    use 'windwp/nvim-ts-autotag'
--Markdown + Zenmode
--Telescope
    use {'nvim-telescope/telescope.nvim', tag = '0.1.2', requires = { {'nvim-lua/plenary.nvim'} }}
--cmp
--    use 'hrsh7th/nvim-cmp'
--cmp plugins
--    use 'hrsh7th/cmp-buffer'
--    use 'hrsh7th/cmp-path'
--    use 'hrsh7th/cmp-cmdline'
--    use 'hrsh7th/cmp-nvim-lsp'
 -- use 'neovim/nvim-lspconfig'

--    use "saadparwaiz1/cmp_luasnip" -- snippet completions

  -- snippets
--  use "L3MON4D3/LuaSnip" --snippet engine
--  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use
--
--  Comments - Toggle comments in Neovim
    use "terrortylor/nvim-comment"

--Autopairs for HTML
   --use {"windwp/nvim-autopairs", wants = "nvim-treesitter", module = { "nvim-autopairs.completion.cmp", "nvim-autopairs" }, config = function()
    --require("config.autopairs").setup() end,}
--CSS
    use 'NvChad/nvim-colorizer.lua'


-- Automatically set up your configuration after cloning packer.nvim
-- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
