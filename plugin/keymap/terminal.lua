require('which-key').add {
  { "<leader>t", group = "[T]erminal" },
  { "<leader>t_", hidden = true },
}

-- Easily hit escape in terminal mode.
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

-- Open terminals
vim.keymap.set("n", "<leader>tt", ":terminal<CR>", { silent = true, desc = "Open a [t]erminal" })

vim.keymap.set("n", "<leader>tb", function()
  vim.cmd.new()
  vim.cmd.wincmd "J"
  vim.api.nvim_win_set_height(0, 12)
  vim.wo.winfixheight = true
  vim.cmd.term()
end, { silent = true, desc = "Open a [t]erminal in at the [b]ottom" })

vim.keymap.set("n", "<leader>tr", function()
  vim.cmd.new()
  vim.cmd.wincmd "L"
  vim.api.nvim_win_set_width(0, 50)
  vim.wo.winfixwidth = true
  vim.cmd.term()
end, { silent = true, desc = "Open a [t]erminal in to the [r]ight" })

-- Set local settings for terminal buffers
local set = vim.opt_local

vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("custom-term-open", {}),
  callback = function()
    set.number = false
    set.relativenumber = false
    set.scrolloff = 0
  end,
})
