local map = vim.keymap.set
return {
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should belsp
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-telescope/telescope-file-browser.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      local actions = require 'telescope.actions'
      local fb_actions = require('telescope').extensions.file_browser.actions
      require('telescope').setup {
        defaults = {
          layout_strategy = 'flex',
        },
        pickers = {
          --theme = 'ivy',
          intial_mode = 'normal',
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },

          file_browser = {
            theme = 'ivy',
            hijack_netrw = true,
            mappings = {
              ['i'] = {},
              ['n'] = {
                ['N'] = fb_actions.create,
                ['h'] = fb_actions.goto_parent_dir,
                ['<C-u>'] = function(prompt_bufnr)
                  for i = 1, 10 do
                    actions.move_selection_previous(prompt_bufnr)
                  end
                end,
                ['<C-d>'] = function(prompt_bufnr)
                  for i = 1, 10 do
                    actions.move_selection_next(prompt_bufnr)
                  end
                end,
              },
            },
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      pcall(require('telescope').load_extension, 'file_browser')
      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      map('n', '<leader>fh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      map('n', '<leader>fk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      map('n', '<leader>ff', builtin.find_files, { desc = '[S]earch [F]iles' })
      map('n', '<leader>fs', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      map('n', '<leader>fw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      map('n', '<leader>fg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      map('n', '<leader>fd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      map('n', '<leader>fr', builtin.resume, { desc = '[S]earch [R]esume' })
      map('n', '<leader>f.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      map('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
      map('n', '<space>fb', function()
        require('telescope').extensions.file_browser.file_browser()
      end, { desc = '[f]ile [b]rowser' })
      map('n', '<space>fB', function()
        require('telescope').extensions.file_browser.file_browser { cwd = vim.fn.expand '%:p:h' }
      end, { desc = '[f]ile [B]rowser (current directory)' })
      map('n', '<leader>fp', function()
        require('telescope').extensions.file_browser.file_browser { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[f]ile [p]icker (config directory)' })
      -- Slightly advanced example of overriding default behavior and theme
      map('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      map('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      map('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },
}
