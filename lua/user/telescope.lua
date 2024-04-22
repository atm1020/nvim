local M = {
 'nvim-telescope/telescope.nvim',
 branch = '0.1.x',
 dependencies = {
  'nvim-lua/plenary.nvim',
  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
   'nvim-telescope/telescope-fzf-native.nvim',
   -- NOTE: If you are having trouble with this installation,
   --       refer to the README for telescope-fzf-native for more instructions.
   build = 'make',
   cond = function()
    return vim.fn.executable 'make' == 1
   end,
  },
 },
}

local function filenameFirst(_, path)
    local tail = vim.fs.basename(path)
    local parent = vim.fs.dirname(path)
    if parent == "." then
      return tail
    end
    return string.format("{%s}\t\t%s", tail, parent)
  end
function M.config()
 local actions = require 'telescope.actions'
 require('telescope').setup {
  defaults = {
   mappings = {
    i = {
     ['<C-c>'] = actions.close,
     ['<C-j>'] = actions.move_selection_next,
     ['<C-k>'] = actions.move_selection_previous,
     ['<S-j>'] = actions.preview_scrolling_down,
     ['<S-k>'] = actions.preview_scrolling_up,
    },
    n = {
     ['<C-c>'] = actions.close,
     ['j'] = actions.move_selection_next,
     ['k'] = actions.move_selection_previous,
    },
   },
   file_ignore_patterns = { 'venv', 'build', '__pycache__', '*.egg-info', 'target', 'mvnw.cmd', 'mvnw' },
  },
    pickers = {
      live_grep = {
        theme = "ivy",
 	path_display = filenameFirst,
      },
      find_files = {
        theme = "dropdown",
        path_display = filenameFirst,
      },


      planets = {
        show_pluto = true,
        show_moon = true,
      },

      -- colorscheme = {
      --   enable_preview = true,
      -- },
    },
    extensions = {
      fzf = {
        fuzzy = true, -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      },
    },
 }
 -- Enable telescope fzf native, if installed
 pcall(require('telescope').load_extension, 'fzf')
 -- Telescope live_grep in git root
 -- Function to find the git root directory based on the current buffer's path
 local function find_git_root()
  -- Use the current buffer's path as the starting point for the git search
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir
  local cwd = vim.fn.getcwd()
  -- If the buffer is not associated with a file, return nil
  if current_file == '' then
   current_dir = cwd
  else
   -- Extract the directory from the current file's path
   current_dir = vim.fn.fnamemodify(current_file, ':h')
  end
  -- Find the Git root directory from the current file's path
  local git_root = vim.fn.systemlist('git -C ' .. vim.fn.escape(current_dir, ' ') .. ' rev-parse --show-toplevel')[1]
  if vim.v.shell_error ~= 0 then
   print 'Not a git repository. Searching on current working directory'
   return cwd
  end
  return git_root
 end
 --
 ---- Custom live_grep function to search in git root
 local function live_grep_git_root()
  local git_root = find_git_root()
  if git_root then
   require('telescope.builtin').live_grep {
    search_dirs = { git_root },
   }
  end
 end
 vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})
 -- See `:help telescope.builtin`
 vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
 vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
 vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
   winblend = 10,
   previewer = false,
  })
 end, { desc = '[/] Fuzzily search in current buffer' })
 local function telescope_live_grep_open_files()
  require('telescope.builtin').live_grep {
   grep_open_files = true,
   prompt_title = 'Live Grep in Open Files',
	winblend = 10,
  }
 end
 vim.keymap.set('n', '<leader>s/', telescope_live_grep_open_files, { desc = '[S]earch [/] in Open Files' })
 vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
 vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
 vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
 vim.keymap.set('n', '<leader>st', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
 vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
 vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
 vim.keymap.set('n', '<leader>go', require('telescope.builtin').git_status, { desc = '[G]it [O]pen Changed file' })
 vim.keymap.set('n', '<leader>gb', require('telescope.builtin').git_branches, { desc = '[G]it checkout [B]ranch' })
 vim.keymap.set('n', '<leader>gs', require('telescope.builtin').git_stash, { desc = '[G]it checkout [S]tash' })
end

return M
