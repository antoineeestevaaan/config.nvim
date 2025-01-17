---@param shortcut string
---@param action string|function
---@param modes? string|string[]
local set = function(shortcut, action, modes)
  vim.keymap.set(modes or { "n", "v" }, shortcut, action)
end

-- yank
set("<leader>y", [["+y]])
set("<leader>Y", [["+y$]])
-- cut
set("<leader>d", [["+d]])
set("<leader>D", [["+d$]])
-- paste
set("<leader>p", [["+p]])
set("<leader>P", [["+P]])
