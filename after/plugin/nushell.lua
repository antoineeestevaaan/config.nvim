vim.opt.shell = "nu"
vim.opt.shellcmdflag = "--stdin --no-newline -c "
-- stop quote everything e.g :!ls -> !'"ls"' -> is not a command
vim.opt.shellquote = ""
vim.opt.shellxquote = ""

-- use pipes instead of temp files.
-- temp files sourced as follows:
--"(ls) < /8aYVe5/2 out+err> /8aYVe5/3"
-- which results in an error in nu.
-- And there is only way to change the second part with 'shellredir', but not the first.
-- neovim "remove shelltemp" discussion: https://github.com/neovim/neovim/issues/1008
vim.opt.shelltemp = false
-- if "shelltemp = false" this is not used
-- vim.opt.shellredir = "out+err> %s"

-- save to an nvim temp file for quickfix buffer and also print to the output window
-- command :make, for example with makeprg = 'lua %s':
-- :!lua test.lua  | tee { save -f --raw /var/TRw4xR/5 }
vim.opt.shellpipe = "| tee { save -f --raw %s }"
