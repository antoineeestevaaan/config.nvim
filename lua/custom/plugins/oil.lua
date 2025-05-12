return {
  'stevearc/oil.nvim',
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local oil = require("oil")

    local detail = false
    local DETAILED_COLUMNS = {
      "icon",
      { "permissions", highlight = "Floatborder" },
      { "size",        highlight = "MatchParen" },
      { "mtime",       highlight = "Whitespace", format = "%Y-%m-%d %T" },
    }

    oil.setup {
      default_file_explorer = true,
      watch_for_changes = false,
      columns = DETAILED_COLUMNS,
      skip_confirm_for_simple_edits = true,
      prompt_save_on_select_new_entry = true,
      keymaps = {
        ["<C-h>"] = false,
        ["<M-h>"] = "actions.select_split",
        ["gd"] = {
          desc = "Toggle file detail view",
          callback = function()
            detail = not detail
            if detail then
              oil.set_columns(DETAILED_COLUMNS)
            else
              oil.set_columns({ "icon" })
            end
          end,
        },
      },
      view_options = {
        show_hidden = true,
      },
    }

    vim.keymap.set("n", "-", oil.open)
    vim.keymap.set("n", "<leader>-", oil.toggle_float)
  end,
}
