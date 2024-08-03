-- Set to true if you have a Nerd Font installed
vim.g.have_nerd_font = true

local function split_on(s, delimiter)
  local result = {}
  local from = 1
  local delim_from, delim_to = string.find(s, delimiter, from)
  while delim_from do
    table.insert(result, string.sub(s, from, delim_from - 1))
    from = delim_to + 1
    delim_from, delim_to = string.find(s, delimiter, from)
  end
  table.insert(result, string.sub(s, from))
  return result
end

local diagnostic_foramt = function(diagnostic)
  return string.format('%s: %s', diagnostic.source, split_on(diagnostic.message, '\n')[1])
end

vim.diagnostic.config {
  virtual_text = {
    prefix = '■',
    format = diagnostic_foramt,
  },
  severity_sort = true,
  float = {
    source = 'if_many',
  },
}

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require 'personal.core.options'
require 'personal.core.keymaps'
require('lazy').setup({
  { import = 'personal.plugins' },
}, {
  ui = {
    colorscheme = 'sonokai',
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',

      conflict = '💥',

      branch = '🔀',
      merged = '🔀',
      pick = '👑',
      unpick = '👑',
      done = '✅',
    },
  },
})
