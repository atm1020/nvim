local M = {
 -- Highlight, edit, and navigate code
 'nvim-treesitter/nvim-treesitter',
 dependencies = {
  'nvim-treesitter/nvim-treesitter-textobjects',
  'nvim-treesitter/playground',
 },
}

function M.config()
 local wk = require 'which-key'
 wk.register {
  ['<leader>Ti'] = { '<cmd>TSConfigInfo<CR>', 'Info' },
 }
 require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'go', 'lua', 'python', 'rust', 'vimdoc', 'vim', 'bash', 'java', 'yaml', "sql" },

  -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  auto_install = false,

  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = {
   enable = true,
   keymaps = {
    init_selection = '<c-space>',
    node_incremental = '<c-space>',
    scope_incremental = '<c-s>',
    node_decremental = '<M-space>',
   },
  },
  textobjects = {
   select = {
    enable = true,
    lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
    keymaps = {
     -- You can use the capture groups defined in textobjects.scm
     ['af'] = '@function.outer',
     ['if'] = '@function.inner',
     ['at'] = '@class.outer',
     ['it'] = '@class.inner',
     ['ac'] = '@call.outer',
     ['ic'] = '@call.inner',
     ['aa'] = '@parameter.outer',
     ['ia'] = '@parameter.inner',
     ['al'] = '@loop.outer',
     ['il'] = '@loop.inner',
     ['ai'] = '@conditional.outer',
     ['ii'] = '@conditional.inner',
     ['a/'] = '@comment.outer',
     ['i/'] = '@comment.inner',
     ['ab'] = '@block.outer',
     ['ib'] = '@block.inner',
     ['as'] = '@statement.outer',
     ['is'] = '@scopename.inner',
     ['aA'] = '@attribute.outer',
     ['iA'] = '@attribute.inner',
     ['aF'] = '@frame.outer',
     ['iF'] = '@frame.inner',
    },
   },
   move = {
    enable = true,
    set_jumps = true, -- whether to set jumps in the jumplist
    goto_next_start = {
     [']m'] = '@function.outer',
     [']]'] = '@class.outer',
    },
    goto_next_end = {
     [']M'] = '@function.outer',
     [']['] = '@class.outer',
    },
    goto_previous_start = {
     ['[m'] = '@function.outer',
     ['[['] = '@class.outer',
    },
    goto_previous_end = {
     ['[M'] = '@function.outer',
     ['[]'] = '@class.outer',
    },
   },
   swap = {
    enable = true,
    swap_next = {
     ['<leader>aa'] = '@parameter.inner',
    },
    swap_previous = {
     ['<leader>AA'] = '@parameter.inner',
    },
   },
  },
  playground = {
   enable = true,
  },
 }
end

return M
