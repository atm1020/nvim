local M = {
 -- Autocompletion
 'hrsh7th/nvim-cmp',
 dependencies = {
  -- Snippet Engine & its associated nvim-cmp source
  'L3MON4D3/LuaSnip',
  'saadparwaiz1/cmp_luasnip',

  -- Adds LSP completion capabilities
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-path',

  -- Adds a number of user-friendly snippets
  'rafamadriz/friendly-snippets',
  'hrsh7th/cmp-buffer',
 },
}

function M.config()
 -- [[ Configure nvim-cmp ]]
 local cmp = require 'cmp'
 local luasnip = require 'luasnip'
 require('luasnip.loaders.from_vscode').lazy_load()
 luasnip.config.setup {}

 cmp.setup {
  snippet = {
   expand = function(args)
    luasnip.lsp_expand(args.body)
   end,
  },
  completion = {
   completeopt = 'menu,menuone,noinsert',
  },
  mapping = cmp.mapping.preset.insert {
   ['<C-j>'] = cmp.mapping.select_next_item(),
   ['<C-k>'] = cmp.mapping.select_prev_item(),
   ['<C-b>'] = cmp.mapping.scroll_docs(-4),
   ['<C-f>'] = cmp.mapping.scroll_docs(4),
   ['<C-Space>'] = cmp.mapping.complete {},
   ['<CR>'] = cmp.mapping.confirm {
    behavior = cmp.ConfirmBehavior.Replace,
    select = true,
   },
  },
  sources = {
   { name = 'nvim_lsp' },
   { name = 'luasnip' },
   { name = 'path' },
   { name = 'buffer' },
  },
 }
end

return M
