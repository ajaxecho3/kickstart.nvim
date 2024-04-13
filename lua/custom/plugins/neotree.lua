if true then
  return {}
end

return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = function()
      require('neo-tree').setup {
        keys = {
          {
            '<leader>fe',
            function()
              require('neo-tree.command').execute { toggle = true, dir = vim.fn.getcwd() }
            end,
            desc = 'Explorer NeoTree (Root Dir)',
          },
          {
            '<leader>fE',
            function()
              require('neo-tree.command').execute { toggle = true, dir = vim.uv.cwd() }
            end,
            desc = 'Explorer NeoTree (cwd)',
          },
          { '<leader>ed', '<leader>fe', desc = 'Explorer NeoTree (Root Dir)', remap = true },
          { '<leader>Ed', '<leader>fE', desc = 'Explorer NeoTree (cwd)', remap = true },
          {
            '<leader>ge',
            function()
              require('neo-tree.command').execute { source = 'git_status', toggle = true }
            end,
            desc = 'Git Explorer',
          },
          {
            '<leader>be',
            function()
              require('neo-tree.command').execute { source = 'buffers', toggle = true }
            end,
            desc = 'Buffer Explorer',
          },
        },
      }
    end,
  },
}
