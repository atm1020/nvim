local M = {
 'ThePrimeagen/harpoon',

 dependency = {
  'nvim-lua/plenary.nvim',
 },
}

function M.config()
 local mark = require 'harpoon.mark'
 local ui = require 'harpoon.ui'

 local wk = require 'which-key'
  wk.add({
    { "<leader>a", mark.add_file, desc = "Harpoon add file" }
 }
	)

 vim.keymap.set('n', '<C-e>', ui.toggle_quick_menu)
 vim.keymap.set('n', '<A-u>', function()
  ui.nav_file(1)
 end)
 vim.keymap.set('n', '<A-i>', function()
  ui.nav_file(2)
 end)
 vim.keymap.set('n', '<A-o>', function()
  ui.nav_file(3)
 end)
 vim.keymap.set('n', '<A-p>', function()
  ui.nav_file(4)
 end)
end
return M
