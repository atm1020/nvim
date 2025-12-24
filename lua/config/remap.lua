local keymap = vim.keymap.set

-- leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--vim.g.mapleader = " "
keymap('n', '<leader>cc', vim.cmd.exit)
keymap('i', 'jk', '<ESC>')

-- Move selected line / block of text in visual mode
keymap('v', 'K', ":m '<-2<CR>gv=gv")
keymap('v', 'J', ":m '>+1<CR>gv=gv")

keymap('n', '<C-h>', '<C-w>h')
keymap('n', '<C-j>', '<C-w>j')
keymap('n', '<C-k>', '<C-w>k')
keymap('n', '<C-l>', '<C-w>l')

keymap({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
keymap('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
keymap('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
keymap('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
keymap('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- split window
keymap('n', '-', ':split <CR>')
keymap('n', '|', ':vsplit <CR>')

-- resize window
keymap('n', '<C-Up>', ':resize -2<CR>', { noremap = true })
keymap('n', '<C-Down>', ':resize +2<CR>', { noremap = true })
keymap('n', '<C-Left>', ':vertical resize -2<CR>', { noremap = true })
keymap('n', '<C-Right>', ':vertical resize +2<CR>', { noremap = true })

keymap('n', '<C-f>', '<cmd>silent !tmux neww tmux-sessionizer<CR>')
keymap('n', '<leader>n', '<cmd>silent !tmux switch -n<CR>') -- next window
keymap('n', '<leader>p', '<cmd>silent !tmux switch -p<CR>') -- previous window
keymap('n', '<leader>l', '<cmd>silent !tmux switch -l<CR>') -- last window
keymap('n', '<leader>oc', '<cmd>silent !tmux new-session -d -s opencode "opencode" \\; switch-client -t opencode<CR>') -- open opencode in new tmux session

keymap('n', '<leader>f', vim.lsp.buf.format)

keymap('x', '<leader>p', [["_dP]])
keymap({ 'n', 'v' }, '<leader>y', [["+y]])

vim.keymap.set('n', '<leader>rr', function()
	local plugin = 'neotest-jdtls'
	local reloader = require('plenary.reload').reload_module
	reloader(plugin)
	require(plugin)
	local client = vim.lsp.get_clients({ name = 'jdtls' })[1]
	vim.api.nvim_exec_autocmds('LspAttach', {
		buffer = vim.api.nvim_get_current_buf(),
		data = { client_id = client.id }, -- fake ID, just for testing your callback path
	})

	print('Reloaded ' .. plugin)
end)


-- For Charm tui dev
vim.keymap.set("n", "<leader>cv", function()
	vim.fn.search("View\\s*(.*)\\s\\+string\\s*{\\s*$")
end, { desc = "Jump to View() string {" })

vim.keymap.set("n", "<leader>cu", function()
	vim.fn.search("Update(msg tea.Msg)")
end, { desc = "Jump to Update(msg tea.Msg)" })

vim.keymap.set("n", "<leader>ci", function()
	vim.fn.search("Init()")
end, { desc = "Jump to Init()" })

vim.keymap.set("n", "<leader>C", function()
	vim.fn.search("New[A-Z][a-zA-Z]*Model")
end, { desc = "Jump to Constructor" })



