vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
local map = vim.keymap.set

--Inlay hints
map('n', '<leader>ih', function()
  ---@diagnostic disable-next-line: missing-parameter
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = 'Toggle inlay hints' })

-- Oil
map('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })

--Current file in Insert Mode
map('i', '<C-s>', '<cmd>write<CR>', { desc = 'Save the current file' })

-- Diagnostic keymaps
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
map('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
-- Split panel
map('n', '<C-w>\\', '<C-w>v', { desc = 'Split panel vertically' })
map('n', '<C-w>-', '<C-w>s', { desc = 'Split panel horizontally' })
map('n', '<C-w>o', '<C-w>o', { desc = 'Close other panels' })
map('n', '<C-w>=', '<C-w>=', { desc = 'Balance all panels' })
map('n', '<C-w>q', '<C-w>q', { desc = 'Close current panel' })

-- Tabs
map('n', '<leader><tab>l', '<cmd>tablast<cr>', { desc = 'Last Tab' })
map('n', '<leader><tab>f', '<cmd>tabfirst<cr>', { desc = 'First Tab' })
map('n', '<leader><tab><tab>', '<cmd>tabnew<cr>', { desc = 'New Tab' })
map('n', '<leader><tab>]', '<cmd>tabnext<cr>', { desc = 'Next Tab' })
map('n', '<leader><tab>d', '<cmd>tabclose<cr>', { desc = 'Close Tab' })
map('n', '<leader><tab>[', '<cmd>tabprevious<cr>', { desc = 'Previous Tab' })

-- fold
-- map('n', '<space>z', 'za', { desc = 'Toggle fold' })
-- map('n', '<space>o', 'zR', { desc = 'Open all folds' })
-- map('n', '<space>c', 'zM', { desc = 'Close all folds' })

-- Create fold
-- map('v', '<space>z', 'zf', { desc = 'Create fold' })

-- Save a file
map('n', '<C-s>', '<cmd>write<CR>', { desc = 'Save the current file' })

-- move code block
map('n', '<C-k>', 'mz:m-2<CR>`z', { desc = 'Move line up' })
map('n', '<C-j>', 'mz:m+<CR>`z', { desc = 'Move line down' })
