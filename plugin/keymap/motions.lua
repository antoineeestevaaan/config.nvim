-- drag lines up and down in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "drag visual lines down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "drag visual lines up" })

-- always stay centered
vim.keymap.set("n", "J", "mzJ`z", { desc = "keep the cursor to the left when merging lines" })
vim.keymap.set("n", "<c-d>", "<c-d>zz", { silent = true, desc = "stay vertically centered when scrolling page down" })
vim.keymap.set("n", "<c-u>", "<c-u>zz", { silent = true, desc = "stay vertically centered when scrolling pages up" })
vim.keymap.set("n", "n", "nzzzv", { desc = "stay vertically centered when going to next match" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "stay vertically centered when going to previous match" })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
