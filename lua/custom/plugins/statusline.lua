return { {
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
} }
