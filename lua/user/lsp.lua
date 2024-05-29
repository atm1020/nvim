local M = {

 'neovim/nvim-lspconfig',
 dependencies = {
  {
   'williamboman/mason.nvim',
   opts = {
    registries = {
     'github:nvim-java/mason-registry',
     'github:mason-org/mason-registry',
    },
   },
  },
  {
   'williamboman/mason-lspconfig.nvim',
   opts = {
    handlers = {
     ['jdtls'] = function()
      require('java').setup()
     end,
    },
   },
  },
  { 'j-hui/fidget.nvim', opts = {} },
  { 'folke/neodev.nvim' },
  {
   'nvim-java/nvim-java',
   dir = '~/workspace/nvim-java/',
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
  },
 },
 opts = {},
}

function M.config()
 require('neodev').setup {}

 local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
   if desc then
    desc = 'LSP: ' .. desc
   end
   vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end
  vim.keymap.set('n', 'gd', function()
   vim.lsp.buf.definition()
  end, {})
  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
  nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  -- nmap('D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  nmap('ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
   vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
 end
 -- Enable the following language servers
 local servers = {
  -- clangd = {},
  gopls = {},
  -- yamlls = {},
  pyright = {},
  jdtls = {},
  -- azure_pipelines_ls = {
  -- 	-- settings = {
  -- 	--     yaml = {
  -- 	--         schemas = {
  -- 	--             ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = {
  -- 	--                 "/azure-pipeline*.y*l",
  -- 	--                 "/*.azure*",
  -- 	--                 "Azure-Pipelines/**/*.y*l",
  -- 	--                 "Pipelines/*.y*l",
  -- 	--                 "templates/*.y*l",
  -- 	--             },
  -- 	--         },
  -- 	--     },
  -- 	-- },
  -- },
  lua_ls = {
   Lua = {
    workspace = { checkThirdParty = false },
    telemetry = { enable = false },
   },
  },
 }

 local capabilities = vim.lsp.protocol.make_client_capabilities()
 capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

 require('mason').setup()
 require('mason-lspconfig').setup()
 local mason_lspconfig = require 'mason-lspconfig'
 mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
 }

 mason_lspconfig.setup_handlers {
  function(server_name)
   require('lspconfig')[server_name].setup {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = servers[server_name],
    filetypes = (servers[server_name] or {}).filetypes,
   }
  end,
 }
end

return M
