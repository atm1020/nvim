local M = { 'akinsho/toggleterm.nvim', version = '*', config = true }

function M.config()
 require('toggleterm').setup {
  direction = 'float',
  open_mapping = [[<c-\>]],
  shell = vim.o.shell,
  terminal_mappings = true,
 }
 function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
  vim.keymap.set('t', '<leader>/', function()
   require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    prompt_title = 'Terminal Fuzzily',
    winblend = 0,
    layout_config = {
     width = 0.8,
    },
    previewer = false,
   })
  end, { desc = '[/] Fuzzily search in current buffer' })
 end

 local function open_tui(cmd, keymap, desc, mode)
  local Terminal = require('toggleterm.terminal').Terminal
  local tui = Terminal:new({
	  cmd = cmd,
	  hidden = true,
  })

  vim.keymap.set(mode, keymap, function()
   tui:toggle()
  end, { desc = desc , noremap = true, silent = true})
 end

 open_tui('lazygit', '<leader>gg', '[G]it [G]ui', 'n')
end

return M
