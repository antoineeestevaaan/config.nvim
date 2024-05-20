local nmap = require("custom._utils").nmap

require('which-key').register {
    ['<leader>w'] = { name = '[W]indows', _ = 'which_key_ignore' },
}

nmap("<leader>wm", "<C-w>_<C-w>|", "[M]aximize the current [w]indow")
nmap("<leader>wc", "<C-w>o", "[C]lose all but the focused [w]indow")
nmap("<leader>we", "<C-w>=", "Make all [w]indows [e]qual")

nmap("<leader>wh", "<C-w>h", "Move focus one [w]indow to the left")
nmap("<leader>wj", "<C-w>j", "Move focus one [w]indow down")
nmap("<leader>wk", "<C-w>k", "Move focus one [w]indow up")
nmap("<leader>wl", "<C-w>l", "Move focus one [w]indow to the right")

nmap("<leader>wH", "<C-w>H", "Move [w]indow to the left")
nmap("<leader>wJ", "<C-w>J", "Move [w]indow down")
nmap("<leader>wK", "<C-w>K", "Move [w]indow up")
nmap("<leader>wL", "<C-w>L", "Move [w]indow to the right")

-- These mappings control the size of splits (height/width)
nmap("<leader>ww", "<c-w>5<", "Make [w]indow [w]ider")
nmap("<leader>wn", "<c-w>5>", "Make [w]indow [n]arrower")
nmap("<leader>wt", "<C-W>+", "Make [w]indow [t]aller")
nmap("<leader>ws", "<C-W>-", "Make [w]indow [s]horter")
