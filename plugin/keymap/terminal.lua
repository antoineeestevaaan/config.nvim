-- a better terminal
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "escape to normal mode in a terminal"})

-- open a terminal
vim.keymap.set("n", "<leader>tt", ":terminal<CR>", { silent = true, desc = "Open a [t]erminal" })
vim.keymap.set("n", "<leader>th", ":split +terminal<CR>", { silent = true, desc = "Open a [t]erminal in a [h]orizontal split" })
vim.keymap.set("n", "<leader>tv", ":vsplit +terminal<CR>", { silent = true, desc = "Open a [t]erminal in a [v]ertical split" })
