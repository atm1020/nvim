local M = {
 -- NOTE: Yes, you can install new plugins here!
 'mfussenegger/nvim-dap',
 -- NOTE: And you can specify dependencies as well
 dependencies = {
  -- Creates a beautiful debugger UI
  'rcarriga/nvim-dap-ui',

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
   "delve",    -- delve ->  go
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

 dapui.setup {
  icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
  controls = {
   icons = {
    pause = '⏸',
    play = '▶',
    step_into = '⏎',
    step_over = '⏭',
    step_out = '⏮',
    step_back = 'b',
    run_last = '▶▶',
    terminate = '⏹',
    disconnect = '⏏',
   },
  },
 }

 vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })
 --dap.listeners.after.event_initialized['dapui_config'] = dapui.open
 --dap.listeners.before.event_terminated['dapui_config'] = dapui.close

 require('dap-go').setup()
 require('dap-python').setup()
 vim.api.nvim_set_keymap('n', '<leader>ad', "<cmd>lua require('custom.debug').attach_to_debug()<CR>", { noremap = true, silent = true })
end
return M
