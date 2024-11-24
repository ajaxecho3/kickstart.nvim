return {
  'supermaven-inc/supermaven-nvim',
  enabled = false,
  config = function()
    require('supermaven-nvim').setup {
      keymaps = {
        accept_suggestion = '<c-g>',
        clear_suggestion = '<c-x>',
        accept_word = '<c-;>',
      },
      color = {
        suggestion_color = '#cccccc',
        cterm = 244,
      },
      log_level = 'info', -- set to "off" to disable logging completely
      disable_inline_completion = false, -- disables inline completion for use with cmp
      disable_keymaps = false, -- disables built in keymaps for more manual control
      condition = function()
        return false
      end, -- condition to check for stopping supermaven, `true` means to stop supermaven when the condition is true.
    }
  end,
}
