vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]], { desc = "paste without overwriting the register" })
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "yank to system clipboard only on demand" })
vim.keymap.set({ "n", "v" }, "<leader>d", [["+d]], { desc = "cut to system clipboard only on demand" })
