return { {
  'hrsh7th/nvim-cmp',
  lazy = false,
  dependencies = {
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    "hrsh7th/cmp-buffer",
    'rafamadriz/friendly-snippets',
    'onsails/lspkind.nvim',
  },
  config = function()
    require "custom.completion"
  end
} }
