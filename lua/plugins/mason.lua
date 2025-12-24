return {
 'williamboman/mason.nvim',
 dependencies = {
  'WhoIsSethDaniel/mason-tool-installer.nvim',
  'mason-org/mason-lspconfig.nvim',
 },
 config = function()
  -- Enable mason
  require('mason').setup {
   ui = {
    border = 'rounded',
   },
  }

  -- require("mason-lspconfig").setup()

  -- Install formatters, and linters
  require('mason-tool-installer').setup {
   ensure_installed = {
    'lua_ls',
    'gopls',
    'bashls',
    'dockerls',
    'jsonls',
    'taplo',
    'yamlls',
    'stylua', -- Lua formatter
    'black', -- Python formatter
    'isort', -- Python import organizer
    'pylint', -- Python linter
    'shellcheck', -- Shell script linter
    'shfmt', -- Shell script formatter
   },
  }
 end,
}
