return {
  {
    'folke/which-key.nvim',
    opts = {},
    config = function()
      require('which-key').register {
        ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
        ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
      }
    end
  },
}
