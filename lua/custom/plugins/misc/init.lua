return {
  {
    "laytan/cloak.nvim",
    config = function()
      require('cloak').setup({
        enabled = true,
        cloak_character = '*',
        highlight_group = 'Comment',
        cloak_length = nil,
        patterns = {
          {
            file_pattern = '.env*',
            cloak_pattern = { '=.+', ':.+', '-.+' }
          },
        },
      })
    end
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = {},
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
          component_separators = { left = ">", right = "<" },
        },
        sections = {
          lualine_c = { "filename" },
        },
      })
    end
  },

  {
    "folke/todo-comments.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    config = function()
      require("todo-comments").setup {}

      vim.keymap.set("n", "<leader>tc", ":TodoTelescope<CR>")
    end
  },

  { "folke/twilight.nvim" },

  { "christoomey/vim-tmux-navigator" },


  { "KilianVounckx/nvim-tetris",     commit = "3a791b74bbee29e2e4452d2776415de4f3f3e08b" },
}
