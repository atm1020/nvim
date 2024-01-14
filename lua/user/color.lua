local M = {
 'navarasu/onedark.nvim',
 lazy = false,
 priority = 1000,
}

function M.config()
 vim.cmd.colorscheme 'onedark'
 require('onedark').setup {
  -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
  style = 'darker',
  priority = 1000,
  code_style = {
   comments = 'none',
   keywords = 'none',
   functions = 'none',
   strings = 'none',
   variables = 'none',
  },
 }
 require('onedark').load()
 vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = 'Orange', bold = true })
 vim.api.nvim_set_hl(0, 'LineNr', { fg = 'White', bold = true })
 vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = 'Orange', bold = true })
end

return M
