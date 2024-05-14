-- quickfix window
vim.keymap.set("n", "<leader>co", "<cmd>copen<CR>", { desc = "open quick list" })
vim.keymap.set("n", "<leader>cc", "<cmd>cclose<CR>", { desc = "close quick list" })
vim.keymap.set("n", "<leader>cj", "<cmd>copen<CR><cmd>cnext<CR>zz", { desc = "next in quick list" })
vim.keymap.set("n", "<leader>ck", "<cmd>copen<CR><cmd>cprev<CR>zz", { desc = "previous in quick list" })

-- loc list
vim.keymap.set("n", "<leader>lo", "<cmd>lopen<CR>", { desc = "open loc list" })
vim.keymap.set("n", "<leader>lc", "<cmd>lclose<CR>", { desc = "close loc list" })
vim.keymap.set("n", "<leader>lj", "<cmd>lopen<CR><cmd>lnext<CR>zz", { desc = "next in loc list" })
vim.keymap.set("n", "<leader>lk", "<cmd>lopen<CR><cmd>lprev<CR>zz", { desc = "previous in loc list" })
