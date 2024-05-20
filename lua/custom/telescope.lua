local nmap = require("custom._utils").nmap
local telescope = require('telescope')
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

-- See `:help telescope` and `:help telescope.setup()`
telescope.setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
        ['<Esc>'] = actions.close,
        ['<C-l>'] = actions.select_vertical,
        ['<C-j>'] = actions.select_horizontal,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(telescope.load_extension, 'fzf')

-- Custom live_grep function to search in git root
local function live_grep_git_root()
  local git_root = require("custom._utils").find_git_root()
  if git_root then
    builtin.live_grep {
      search_dirs = { git_root },
    }
  end
end
vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})

-- See `:help telescope.builtin`
nmap('<leader>?', builtin.oldfiles, '[?] Find recently opened files')
nmap('<leader><space>', function()
  builtin.buffers {
    ignore_current_buffer = true,
    sort_last_used = true
  }
end, '[ ] Find existing buffers')
nmap('<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, '[/] Fuzzily search in current buffer')

nmap('<leader>sgf', builtin.git_files, 'Search [G]it [F]iles')
local function telescope_live_grep_open_files()
  builtin.live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end
nmap('<leader>s/', telescope_live_grep_open_files, '[S]earch [/] in Open Files')
nmap('<leader>ss', builtin.builtin, '[S]earch [S]elect Telescope')
nmap('<leader>gf', builtin.git_files, 'Search [G]it [F]iles')
nmap('<leader>sf', builtin.find_files, '[S]earch [F]iles')
nmap('<leader>sh', builtin.help_tags, '[S]earch [H]elp')
nmap('<leader>sw', builtin.grep_string, '[S]earch current [W]ord')
nmap('<leader>slg', builtin.live_grep, '[S]earch by [G]rep')
nmap('<leader>sG', ':LiveGrepGitRoot<cr>', '[S]earch by [G]rep on Git Root')
nmap('<leader>sd', builtin.diagnostics, '[S]earch [D]iagnostics')
nmap('<leader>sr', builtin.resume, '[S]earch [R]esume')
