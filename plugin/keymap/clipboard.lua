local set = function(shortcut, action, modes)
  vim.keymap.set(modes or { "n", "v" }, shortcut, action)
end

-- yank
set("<leader>y", [["+y]])
set("<leader>Y", [["+Y]])
-- cut
set("<leader>d", [["+d]])
set("<leader>D", [["+D]])
-- paste
set("<leader>p", [["+p]])
set("<leader>P", [["+P]])
