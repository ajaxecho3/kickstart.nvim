-- vim.api.nvim_create_autocmd('BufWritePre', {
--   group = vim.api.nvim_create_augroup('mycolorschemegroup', {}),
--   callback = function()
--     vim.cmd.colorscheme 'rose-pine-moon'
--   end,
-- })
--
function ColorMyPencils(color)
  color = color or 'rose-pine-moon'
  vim.cmd.colorscheme(color)

  vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
end

return {
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    config = function()
      require('rose-pine').setup {
        variant = 'moon', -- auto, main, moon, or dawn
        dark_variant = 'moon', -- main, moon, or dawn
        dim_inactive_windows = false,
        extend_background_behind_borders = true,
        styles = {
          italic = false,
          transparent = true,
        },
      }

      ColorMyPencils()
    end,
    -- lazy = true,
    -- priority = 1000,
    -- config = function()
    --   vim.cmd.colorscheme 'rose-pine'
    --
    --   -- You can configure the colorscheme here
    --   --  For example, you can set the `style` to 'storm' or 'day'
    --   -- require('rose-pine').setup { style = 'moon' }
    -- end,
  },

  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      --     vim.cmd.colorscheme 'tokyonight-night'

      -- You can configure highlights by doing something like:
      vim.cmd.hi 'Comment gui=none'
    end,
    config = function()
      -- You can configure the colorscheme here
      --  For example, you can set the `style` to 'storm' or 'day'
      require('tokyonight').setup { transparent = true }
    end,
  },
}
