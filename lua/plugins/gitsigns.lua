local M = {
	'lewis6991/gitsigns.nvim',
	event = 'VeryLazy',
}

function M.config()
	require('gitsigns').setup {
		signs = {
			add = { text = '+' },
			change = { text = '~' },
			delete = { text = '_' },
			topdelete = { text = '‾' },
			changedelete = { text = '~' },
		},
		signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
		numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
		linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
		word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
		watch_gitdir = {
			interval = 1000,
			follow_files = true,
		},
		attach_to_untracked = true,
		current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
			delay = 1000,
			ignore_whitespace = false,
		},
		sign_priority = 6,
		update_debounce = 100,
		status_formatter = nil, -- Use default
		max_file_length = 40000,
		preview_config = {
			-- Options passed to nvim_open_win
			border = 'single',
			style = 'minimal',
			relative = 'cursor',
			row = 0,
			col = 1,
		},
		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns

			local function map(mode, l, r, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, l, r, opts)
			end

			-- Navigation between hunks
			-- map('n', ']c', function()
			-- 	if vim.wo.diff then
			-- 		return ']c'
			-- 	end
			-- 	vim.schedule(function()
			-- 		gs.next_hunk()
			-- 	end)
			-- 	return '<Ignore>'
			-- end, { expr = true, desc = 'Next git hunk' })

			-- map('n', '[c', function()
			-- 	if vim.wo.diff then
			-- 		return '[c'
			-- 	end
			-- 	vim.schedule(function()
			-- 		gs.prev_hunk()
			-- 	end)
			-- 	return '<Ignore>'
			-- end, { expr = true, desc = 'Previous git hunk' })

			-- Actions
			-- map('n', '<leader>hs', gs.stage_hunk, { desc = 'Git [H]unk [S]tage' })
			-- map('n', '<leader>hr', gs.reset_hunk, { desc = 'Git [H]unk [R]eset' })
			-- map('v', '<leader>hs', function()
			-- 	gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') }
			-- end, { desc = 'Git [H]unk [S]tage (visual)' })
			-- map('v', '<leader>hr', function()
			-- 	gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') }
			-- end, { desc = 'Git [H]unk [R]eset (visual)' })
			-- map('n', '<leader>hS', gs.stage_buffer, { desc = 'Git Stage Buffer' })
			-- map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'Git [H]unk [U]ndo stage' })
			-- map('n', '<leader>hR', gs.reset_buffer, { desc = 'Git Reset Buffer' })
			-- map('n', '<leader>hp', gs.preview_hunk, { desc = 'Git [H]unk [P]review' })
			-- map('n', '<leader>hb', function()
			-- 	gs.blame_line { full = true }
			-- end, { desc = 'Git [H]unk [B]lame line' })
			-- map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = '[T]oggle git [B]lame line' })
			-- map('n', '<leader>hd', gs.diffthis, { desc = 'Git [H]unk [D]iff this' })
			-- map('n', '<leader>hD', function()
			-- 	gs.diffthis('~')
			-- end, { desc = 'Git [H]unk [D]iff this ~' })
			-- map('n', '<leader>td', gs.toggle_deleted, { desc = '[T]oggle git show [D]eleted' })

			-- Text object
			-- map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'Select git hunk' })
		end,
	}
end

return M
