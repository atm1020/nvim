local M = {
 'nvim-tree/nvim-tree.lua',
}

function M.config()
 local function my_on_attach(bufnr)
  local api = require 'nvim-tree.api'

  local function opts(desc)
   return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)
  -- custom mappings
  vim.keymap.set('n', '<leader>e', api.tree.toggle)
  vim.keymap.set('n', '<leader>ft', api.tree.find_file)
  -- vim.keymap.set('n', '<leader>t', api.node.open.edit, opts 'Open')
  vim.keymap.set('n', '<C-v>', api.node.open.vertical, opts 'Open: Vertical Split')
  vim.keymap.set('n', '<C-h>', api.node.open.horizontal, opts 'Open: Horizontal Split')
 end

 require('nvim-tree').setup {
  on_attach = my_on_attach,
  sort = {
   sorter = 'case_sensitive',
  },
  view = {
   width = 30,
  },
  renderer = {
   group_empty = true,
  },
  filters = {
   dotfiles = true,
  },
 }
end
return M
