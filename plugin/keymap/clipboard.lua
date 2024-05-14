-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "paste without overwriting the register" })

-- next greatest remaps ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "yank to system clipboard only on demand" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "yank to system clipboard only on demand" })

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "cut to system clipboard only on demand" })
