local M = {
 'nvim-java/nvim-java',
 dir = '~/workspace/nvim-java-origin/',
 dependencies = {
  'nvim-java/lua-async-await',
  'nvim-java/nvim-java-refactor',
  {
   'nvim-java/nvim-java-test',
   -- dir = '~/workspace/nvim-java-test/'
  },
  {
   'atm1020/nvim-java-core',
   -- dir = '~/workspace/nvim-java-core/'
  },
  {
   'nvim-java/nvim-java-dap',
   -- dir = '~/workspace/nvim-java-dap/'
  },
  'MunifTanjim/nui.nvim',
  'neovim/nvim-lspconfig',
  'mfussenegger/nvim-dap',
  'nvim-lua/plenary.nvim',
  {
   'stevearc/overseer.nvim',
   opts = {},
  },
 },
}

function M.config() end

return M
