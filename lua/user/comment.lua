local M = {
 'numToStr/Comment.nvim',
 lazy = false,
 dependencies = {

  {
   'JoosepAlviste/nvim-ts-context-commentstring',
   event = 'VeryLazy',
  },
 },
}

function M.config()
 local wk = require 'which-key'
 wk.add {
  { "<leader>/", "<Plug>(comment_toggle_linewise_current)", desc = "Comment" },
 }

 wk.add {
    { "<leader>/", "<Plug>(comment_toggle_linewise_visual)", desc = "Comment", mode = "v" },
 }
end

return M
