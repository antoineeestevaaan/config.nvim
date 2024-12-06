return {
  {
    'folke/which-key.nvim',
    opts = {},
    config = function()
      require('which-key').add {
        { "<leader>g", group = "[G]it" },
        { "<leader>g_", hidden = true },
        { "<leader>s", group = "[S]earch" },
        { "<leader>s_", hidden = true },
      }
    end
  },
}
