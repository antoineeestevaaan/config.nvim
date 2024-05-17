vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

vim.keymap.set("n", "<Esc>", ":nohlsearch<CR><Esc>", { silent = true, desc = "Escape and remove the search highlight" })

vim.keymap.set("n", "<c-p>", vim.cmd.Ex, { silent = true, desc = "O[p]en the [f]ile explorer" })

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "get out of insert mode with control + C" })

vim.keymap.set("n", "Q", "<nop>", { desc = "do not do anything on Q" })

vim.keymap.set(
    "n", "<leader>xs", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "replace all occurences of the work under the cursor" }
)
vim.keymap.set(
    "n", "<leader>xx", "<cmd>!chmod +x %<CR>",
    { silent = true, desc = "make the current buffer executable" }
)

if vim.lsp.inlay_hint then
    vim.keymap.set(
        'n',
        '<leader>lih',
        function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end,
        { desc = 'Toggle Inlay Hints' }
    )
end
