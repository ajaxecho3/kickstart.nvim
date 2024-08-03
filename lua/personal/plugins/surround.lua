return {
  {
    'echasnovski/mini.surround',
    version = '*',
    config = function()
      require('mini.surround').setup {
        keys = function(opts, keys)
          local mappings = {
            { opts.mappings.add, desc = 'Add Surrounding', mode = { 'n', 'v' } },
            { opts.mappings.delete, desc = 'Delete Surrounding' },
            { opts.mappings.find, desc = 'Find Right Surrounding' },
            { opts.mappings.find_left, desc = 'Find Left Surrounding' },
            { opts.mappings.highlight, desc = 'Highlight Surrounding' },
            { opts.mappings.replace, desc = 'Replace Surrounding' },
            { opts.mappings.update_n_lines, desc = 'Update `MiniSurround.config.n_lines`' },
          }

          mappings = vim.tbl_filter(function(m)
            return m[1] and #m[1] > 0
          end, mappings)
          return vim.list_extend(mappings, keys)
        end,
        mappings = {
          add = 'gsA',
          delete = 'gsD',
          find = 'gsf',
          find_left = 'gsF',
          highlight = 'gsH',
          replace = 'gsR',
          update_n_lines = 'gsN',
        },
      }
    end,
  },
}
