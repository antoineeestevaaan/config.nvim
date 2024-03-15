return {
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  'tpope/vim-rhubarb',

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  {
    'rmagatti/goto-preview',
    config = function()
      local goto_preview = require('goto-preview')
      goto_preview.setup {}

      vim.keymap.set("n", "<leader>gpd", function() goto_preview.goto_preview_definition() end, { silent = true, desc = "" })
      vim.keymap.set("n", "<leader>gpt", function() goto_preview.goto_preview_type_definition() end, { silent = true, desc = "" })
      vim.keymap.set("n", "<leader>gpi", function() goto_preview.goto_preview_implementation() end, { silent = true, desc = "" })
      vim.keymap.set("n", "<leader>gP", function() goto_preview.close_all_win() end, { silent = true, desc = "" })
      vim.keymap.set("n", "<leader>gpr", function() goto_preview.goto_preview_references() end, { silent = true, desc = "" })
    end
  },

  -- motion in space and time
  {
    "theprimeagen/harpoon",
    config = function()
      local mark = require("harpoon.mark")
      local ui = require("harpoon.ui")

      vim.keymap.set("n", "<leader>ha", mark.add_file, { silent = true, desc = "[h]arpoon: [a]dd a file to the menu" })
      vim.keymap.set("n", "<leader>he", ui.toggle_quick_menu,
        { silent = true, desc = "[h]arpoon: toggle menu [e]ntries" })
      vim.keymap.set("n", "<leader>hh", function() ui.nav_file(1) end,
        { silent = true, desc = "[h]arpoon: go to first item (left [h])" })
      vim.keymap.set("n", "<leader>hj", function() ui.nav_file(2) end,
        { silent = true, desc = "[h]arpoon: go to second item (down [j])" })
      vim.keymap.set("n", "<leader>hk", function() ui.nav_file(3) end,
        { silent = true, desc = "[h]arpoon: go to third item (up [k])" })
      vim.keymap.set("n", "<leader>hl", function() ui.nav_file(4) end,
        { silent = true, desc = "[h]arpoon: go to fourth item (right [l])" })
    end
  },

  {
    "mbbill/undotree",
    config = function()
      vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
    end
  },

  -- misc
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


  { "KilianVounckx/nvim-tetris", commit = "3a791b74bbee29e2e4452d2776415de4f3f3e08b" },
}
