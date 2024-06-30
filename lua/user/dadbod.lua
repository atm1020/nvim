local M = {
"tpope/vim-dadbod",
"kristijanhusak/vim-dadbod-completion",
{'kristijanhusak/vim-dadbod-ui',
  dependencies = {
    { 'tpope/vim-dadbod', lazy = true },
    { 'kristijanhusak/vim-dadbod-completion', ft = {'sql'}, lazy = true },
  },
  cmd = {
    'DBUI',
    'DBUIToggle',
    'DBUIAddConnection',
    'DBUIFindBuffer',
  },
  init = function()
    vim.g.db_ui_use_nerd_fonts = 1
  end,
}
}

function M.config()
	vim.keymap.set('n', '<leader>du', ':DBUIToggle<CR>', { desc = '[D]atabase [U]I' })
end
return M
