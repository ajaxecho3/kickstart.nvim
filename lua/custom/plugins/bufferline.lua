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
      -- highlights = {
      --
      --   separator = {
      --     fg = '#073642',
      --     bg = '#002b36',
      --   },
      --   separator_selected = {
      --     fg = '#073642',
      --   },
      --   background = {
      --     fg = '#657b83',
      --     bg = '#002b36',
      --   },
      --   buffer_selected = {
      --     fg = '#fdf6e3',
      --     gui = 'bold',
      --   },
      --   fill = {
      --     bg = '#002b36',
      --   },
      -- },

      options = {

        indicator = { style = 'none' },
        buffer_close_icon = '',
        separator_style = { '⦚', '⦚' },
        always_show_bufferline = false,
        color_icons = true,
        offsets = {
          {
            filetype = 'neo-tree',
            text = 'Explorer',
            text_align = 'center',
          },
        },
        custom_areas = {
          right = function()
            local result = {}
            local seve = vim.diagnostic.severity
            local error = #vim.diagnostic.get(0, { severity = seve.ERROR })
            local warning = #vim.diagnostic.get(0, { severity = seve.WARN })
            local info = #vim.diagnostic.get(0, { severity = seve.INFO })
            local hint = #vim.diagnostic.get(0, { severity = seve.HINT })

            if error ~= 0 then
              table.insert(result, { text = '  ' .. error, fg = '#EC5241' })
            end
            if warning ~= 0 then
              table.insert(result, { text = '  ' .. warning, fg = '#EFB839' })
            end

            if hint ~= 0 then
              table.insert(result, { text = '  ' .. hint, fg = '#A3BA5E' })
            end

            if info ~= 0 then
              table.insert(result, { text = '  ' .. info, fg = '#7EA9A7' })
            end
            return result
          end,
        },
      },
    }
  end,
}
