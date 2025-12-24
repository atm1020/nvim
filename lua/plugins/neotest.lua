local M = {
 'nvim-neotest/neotest',
 dir = '~/workspace/neotest/',
 dependencies = {
  'nvim-neotest/neotest-python',
  'nvim-neotest/nvim-nio',
  {
   'atm1020/neotest-jdtls',
   dir = '~/workspace/neotest-jdtls',
   dependencies = {
	       'folke/trouble.nvim',
   },
   -- dependencies = {
   -- 	'folke/trouble.nvim',
   -- },
  },
  'nvim-lua/plenary.nvim',
  'antoinemadec/FixCursorHold.nvim',
  'nvim-treesitter/nvim-treesitter',
  'nvim-neotest/neotest-plenary',
 },
}
function M.config()
 vim.keymap.set('n', '<leader>tt', ':lua require("neotest").summary.toggle()<CR>', { silent = true, desc = '[T]oggle test summary' })
 vim.keymap.set('n', '<leader>tf', ':require("neotest").run.run()<CR>', { silent = true, desc = '[T]est current [F]ile' })

 -- vim.g.neotest_jdtls_log_level= 'debug'
 require('neotest').setup {
  -- log_level = "debug",
  adapters = {
   require 'neotest-jdtls',
   require 'neotest-python' {
    dap = { justMyCode = false },
   },
  },
 }
end

return M
