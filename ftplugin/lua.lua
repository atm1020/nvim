vim.keymap.set('n', '<leader>pt', '<Plug>PlenaryTestFile', { silent = true })

require('neotest').setup {
 adapters = {
  require 'neotest-plenary',
 },
}
