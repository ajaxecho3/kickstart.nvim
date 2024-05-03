return {
  'akinsho/bufferline.nvim',
  event = 'VeryLazy',
  keys = {
    { '<leader>bp', ':BufferLineTogglePin<CR>', desc = 'Toggle pin' },
    { '<leader>bP', ':BufferLineGroupClose ungrouped<CR>', desc = 'Delete non-pinned buffers' },
    { '<leader>bb', ':BufferLinePick<CR>', desc = 'Pick buffer' },
    { '<leader>bd', ':BufferLinePickClose<CR>', desc = 'Pick and close buffer' },
    { '<leader>be', ':BufferLineSortByExtension<CR>', desc = 'Sort by extension' },
    { '<leader>bn', ':BufferLineCycleNext<CR>', desc = 'Next buffer' },
    { '<leader>bp', ':BufferLineCyclePrev<CR>', desc = 'Previous buffer' },
    { '<leader>bs', ':BufferLineSortByDirectory<CR>', desc = 'Sort by directory' },
    { '<leader>bt', ':BufferLineSortByTabs<CR>', desc = 'Sort by tabs' },
    { '<leader>bw', ':BufferLineCloseAllButCurrent<CR>', desc = 'Close all but current buffer' },
    { '<leader>bx', ':BufferLineClose<CR>', desc = 'Close buffer' },
  },
  opts = {},
  config = function()
    require('bufferline').setup {
      highlights = {},
      options = {

        indicator = { style = 'none' },
        buffer_close_icon = '',
        separator_style = 'slope',
        always_show_bufferline = false,
        offsets = {
          {
            filetype = 'neo-tree',
            text = 'Explorer',
            text_align = 'center',
          },
        },
      },
    }
  end,
}
