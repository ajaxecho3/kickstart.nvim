return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    local lualine = require 'lualine'
    -- local colors = {
    --   bg = '#202328',
    --   fg = '#bbc2cf',
    --   yellow = '#ECBE7B',
    --   cyan = '#008080',
    --   darkblue = '#081633',
    --   green = '#98be65',
    --   orange = '#FF8800',
    --   violet = '#a9a1e1',
    --   magenta = '#c678dd',
    --   blue = '#51afef',
    --   red = '#ec5f67',
    -- }
    local colors = require('cyberdream.colors').default
    local cyberdream = require 'lualine.themes.cyberdream'
    local copilot_colors = {
      [''] = { fg = colors.grey, bg = colors.none },
      ['Normal'] = { fg = colors.grey, bg = colors.none },
      ['Warning'] = { fg = colors.red, bg = colors.none },
      ['InProgress'] = { fg = colors.yellow, bg = colors.none },
    }

    local conditions = {
      buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand '%:t') ~= 1
      end,
      hide_in_width = function()
        return vim.fn.winwidth(0) > 80
      end,
      check_git_workspace = function()
        local filepath = vim.fn.expand '%:p:h'
        local gitdir = vim.fn.finddir('.git', filepath .. ';')
        return gitdir and #gitdir > 0 and #gitdir < #filepath
      end,
    }

    local config = {
      options = {
        -- Disable sections and component separators
        component_separators = '',
        section_separators = '',
        -- theme = {
        --   -- We are going to use lualine_c an lualine_x as left and
        --   -- right section. Both are highlighted by c theme .  So we
        --   -- are just setting default looks o statusline
        --   normal = { c = { fg = colors.fg, bg = colors.bg } },
        --   inactive = { c = { fg = colors.fg, bg = colors.bg } },
        -- },
        theme = cyberdream,
        globalstatus = true,
        disabled_filetypes = { statusline = { 'dashboard', 'alpha' } },
      },
      sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        -- These will be filled later
        lualine_c = {},
        lualine_x = {},
      },
      winbar = {
        lualine_c = {
          {
            function()
              return require('nvim-navic').get_location()
            end,
            cond = function()
              return package.loaded['nvim-navic'] and require('nvim-navic').is_available()
            end,
            color = { fg = colors.grey, bg = colors.none },
          },
        },

        lualine_x = {
          {
            'branch',
            icon = '',
            color = { fg = colors.violet, gui = 'bold' },
          },
        },
      },

      inactive_sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
      },
    }

    -- Inserts a component in lualine_c at left section
    local function ins_left(component)
      table.insert(config.sections.lualine_c, component)
    end

    -- Inserts a component in lualine_x at right section
    local function ins_right(component)
      table.insert(config.sections.lualine_x, component)
    end
    --display mode component as string
    ins_left {
      function()
        local mode_alias = {
          n = 'NORMAL',
          i = 'INSERT',
          c = 'COMMAND',
          V = 'VISUAL',
          [''] = 'VISUAL',
          v = 'VISUAL',
          R = 'REPLACE',
          t = 'TERMINAL',
        }
        return ' ' .. mode_alias[vim.fn.mode()] .. ' '
      end,
      color = function()
        -- auto change color according to neovims mode
        local mode_color = {
          n = colors.red,
          i = colors.green,
          v = colors.blue,
          [''] = colors.blue,
          V = colors.blue,
          c = colors.magenta,
          no = colors.red,
          s = colors.orange,
          S = colors.orange,
          [' '] = colors.orange,
          ic = colors.yellow,
          R = colors.violet,
          Rv = colors.violet,
          cv = colors.red,
          ce = colors.red,
          r = colors.cyan,
          rm = colors.cyan,
          ['r?'] = colors.cyan,
          ['!'] = colors.red,
          t = colors.red,
        }
        return { fg = mode_color[vim.fn.mode()] }
      end,
    }
    ins_left {
      -- mode component
      function()
        return ''
      end,
      color = function()
        -- auto change color according to neovims mode
        local mode_color = {
          n = colors.red,
          i = colors.green,
          v = colors.blue,
          [''] = colors.blue,
          V = colors.blue,
          c = colors.magenta,
          no = colors.red,
          s = colors.orange,
          S = colors.orange,
          [''] = colors.orange,
          ic = colors.yellow,
          R = colors.violet,
          Rv = colors.violet,
          cv = colors.red,
          ce = colors.red,
          r = colors.cyan,
          rm = colors.cyan,
          ['r?'] = colors.cyan,
          ['!'] = colors.red,
          t = colors.red,
        }
        return { fg = mode_color[vim.fn.mode()] }
      end,
      padding = { left = 0, right = 1 },
    }

    ins_left {
      -- filesize component
      'filesize',
      cond = conditions.buffer_not_empty,
    }

    ins_left {
      'filename',
      cond = conditions.buffer_not_empty,
      color = { fg = colors.magenta, gui = 'bold' },
    }

    ins_left { 'location' }

    ins_left { 'progress', color = { fg = colors.fg, gui = 'bold' } }

    -- ins_left {
    --   'diagnostics',
    --   sources = { 'nvim_diagnostic' },
    --   symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
    --   -- diagnostics_color = {
    --   --   color_error = { fg = colors.red },
    --   --   color_warn = { fg = colors.yellow },
    --   --   color_info = { fg = colors.cyan },
    --   -- },
    -- }
    -- Insert mid section. You can make any number of sections in neovim :)
    -- for lualine it's any number greater then 2
    ins_left {
      function()
        return '%='
      end,
    }
    -- Programming languages
    ins_left {
      'filetype',
      icon_only = true,
      seperator = '',
      padding = { left = 1, right = 0 },
      color = { fg = colors.green, gui = 'bold' },
    }

    -- ins_left {
    --        -- function()
    --   local syntax = vim.bo.filetype
    --   if syntax == 'typescript' then
    --     return 'TS'
    --   elseif syntax == 'javascript' then
    --     return 'JS'
    --   elseif syntax == 'python' then
    --     return 'PY'
    --   elseif syntax == 'java' then
    --     return 'JAVA'
    --   elseif syntax == 'c' then
    --     return 'C'
    --   elseif syntax == 'cpp' then
    --     return 'CPP'
    --   elseif syntax == 'go' then
    --     return 'GO'
    --   elseif syntax == 'rust' then
    --     return 'RUST'
    --   elseif syntax == 'lua' then
    --     return 'LUA'
    --   elseif syntax == 'html' then
    --     return 'HTML'
    --   elseif syntax == 'css' then
    --     return 'CSS'
    --   elseif syntax == 'json' then
    --     return 'JSON'
    --   elseif syntax == 'yaml' then
    --     return 'YAML'
    --   elseif syntax == 'vim' then
    --     return 'VIM'
    --   else
    --     return syntax
    --   end
    -- end,
    --[[ } ]]

    -- Add components to right sections
    ins_right {
      'o:encoding', -- option component same as &encoding in viml
      fmt = string.upper, -- I'm not sure why it's upper case either ;)
      cond = conditions.hide_in_width,
      color = { fg = colors.green, gui = 'bold' },
    }

    ins_right {
      'fileformat',
      fmt = string.upper,
      icons_enabled = true, -- I think icons are cool but Eviline doesn't have them. sigh
      color = { fg = colors.green, gui = 'bold' },
    }

    ins_right {
      'diff',
      -- Is it me or the symbol for modified us really weird
      symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
      diff_color = {
        added = { fg = colors.green },
        modified = { fg = colors.orange },
        removed = { fg = colors.red },
      },
      cond = conditions.hide_in_width,
    }

    ins_right {
      function()
        local icon = ' '
        local status = require('copilot.api').status.data
        return icon .. (status.message or '')
      end,
      cond = function()
        local ok, clients = pcall(vim.lsp.get_active_clients, { name = 'copilot', bufnr = 0 })
        return ok and #clients > 0
      end,
      color = function()
        if not package.loaded['copilot'] then
          return
        end
        local status = require('copilot.api').status.data
        return copilot_colors[status.status] or copilot_colors['']
      end,
    }
    ins_right {
      -- Lsp server name .
      function()
        local msg = 'No Active Lsp'
        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
          return msg
        end
        for _, client in ipairs(clients) do
          local filetypes = client.config.filetypes
          if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            return client.name
          end
        end
        return msg
      end,
      icon = ' LSP:',
      color = { fg = '#ffffff', gui = 'bold' },
    }

    -- Now don't forget to initialize lualine
    lualine.setup(config)
  end,
}
