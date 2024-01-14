local M = {
 'mbbill/undotree',
}

function M.config()
 vim.keymap.set('n', '<leader>ud', ':UndotreeToggle<CR>', { desc = '[U]ndo [D]irectory' })
end

return M
