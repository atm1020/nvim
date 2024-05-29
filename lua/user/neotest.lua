local M = {
 'nvim-neotest/neotest',
 -- dir = '~/workspace/neotest/',
 dependencies = {
  'nvim-neotest/neotest-python',
  'nvim-neotest/nvim-nio',
  { 'atm1020/neotest-jdtls', dir = '~/workspace/neotest-jdtls' },
  'nvim-lua/plenary.nvim',
  'antoinemadec/FixCursorHold.nvim',
  'nvim-treesitter/nvim-treesitter',
  'nvim-neotest/neotest-plenary',
 },
}
function M.config()
 vim.keymap.set('n', '<leader>tt', ':lua require("neotest").summary.toggle()<CR>', { silent = true, desc = '[T]oggle test summary' })
end
return M
