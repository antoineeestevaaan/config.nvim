return { {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'williamboman/mason.nvim', config = true },
    'williamboman/mason-lspconfig.nvim',
    { 'j-hui/fidget.nvim',       opts = {} },
    'folke/neodev.nvim',
    "folke/trouble.nvim",
    "nvim-tree/nvim-web-devicons",
    'rmagatti/goto-preview',
  },
  config = function()
    require("custom.lsp")
  end,
} }
