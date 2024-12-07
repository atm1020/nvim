local M = {
	-- NOTE: Yes, you can install new plugins here!
	'mfussenegger/nvim-dap',
	-- NOTE: And you can specify dependencies as well
	dependencies = {
		-- Creates a beautiful debugger UI
		'rcarriga/nvim-dap-ui',
		'nvim-neotest/nvim-nio',

		-- Installs the debug adapters for you
		'williamboman/mason.nvim',
		'jay-babu/mason-nvim-dap.nvim',

		-- Add your own debuggers here
		'leoluz/nvim-dap-go',
		'mfussenegger/nvim-dap-python',
		'rcarriga/cmp-dap',
	},
}

M.config = function()
	local dap = require 'dap'
	local dapui = require 'dapui'

	require('mason-nvim-dap').setup {
		automatic_setup = true,
		handlers = {},
		ensure_installed = {
			'delve', -- delve ->  go
			'python', -- debugpy
		},
	}

	vim.keymap.set('n', '<leader>dr', dap.repl.open, { desc = 'opn jsut repl' })
	--    vim.keymap.set('n', '<leader>ds', dap.scopes.open, { desc = 'opn jsut repl'} )

	-- Basic debugging keymaps, feel free to change to your liking!
	vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
	vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
	vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
	vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
	vim.keymap.set('n', '<leader>dl', dap.run_last, { desc = 'Debug: Step Out' })
	vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
	vim.keymap.set('n', '<leader>B', function()
		dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
	end, { desc = 'Debug: Set Breakpoint' })

	vim.keymap.set('n', '<leader>de', ':lua require("dapui").eval()<CR>')
	vim.keymap.set('n', '<leader>dc', ':lua require("dapui").close()<CR>')
	vim.keymap.set('n', '<leader>do', ':lua require("dapui").open()<CR>')
	vim.keymap.set('n', '<leader>dw', ':lua require("dapui").float_element("watches")<CR>')
	vim.keymap.set('n', '<leader>ds', ':lua require("dapui").float_element("scopes")<CR>')
	vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

	dapui.setup {
		layouts = {
			{
				elements = {
					{ id = 'repl',    size = 0.30 },
					{ id = 'console', size = 0.70 },
				},
				size = 20,
				position = 'bottom',
			},
		},
	}

	dap.listeners.after.event_initialized['dapui_confg'] = require('dapui').open

	require('dap-go').setup()
	require('dap-python').setup()
	require('cmp').setup {
		enabled = function()
			return vim.api.nvim_buf_get_option(0, 'buftype') ~= 'prompt' or
			require('cmp_dap').is_dap_buffer()
		end,
	}

	require('cmp').setup.filetype({ 'dap-repl', 'dapui_watches', 'dapui_hover' }, {
		sources = {
			{ name = 'dap' },
		},
	})
end
return M
