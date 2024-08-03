return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufRead', 'BufNewFile' },
    dependencies = {
      'windwp/nvim-ts-autotag',
      'nvim-treesitter/nvim-treesitter-textobjects',
      'nvim-treesitter/nvim-treesitter-refactor',
      'nvim-treesitter/nvim-treesitter-context',
    },
    opts = {
      ensure_installed = { 'go', 'rust', 'tsx', 'bash', 'c', 'html', 'lua', 'luadoc', 'markdown', 'vim', 'vimdoc', 'javascript', 'typescript' },
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
      incremental_selection = {
        enable = true,
        keymaps = { init_selection = 'gnn', node_incremental = 'grn', scope_incremental = 'grc', node_decremental = 'grm' },
      },
      autopairs = {
        enable = true,
      },

      autotag = function()
        require('nvim-ts-autotag').setup {
          opts = {
            enable_close = true,
            update_on_move = true,
            enable_rename = true,
            enable_close_on_slash = true,
            filetypes = {
              'html',
              'javascript',
              'typescript',
              'javascriptreact',
              'typescriptreact',
              'svelte',
              'vue',
              'tsx',
              'jsx',
              'rescript',
              'xml',
              'php',
              'markdown',
              'astro',
              'glimmer',
              'handlebars',
              'hbs',
            },
          },
        }
      end,
    },

    config = function(_, opts)
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)
      -- There are additional nvim-treesitter modules that you can use to interact
      -- with nvim-treesitter. You should go explore a few and see what interests you:
      --
      --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
      --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    end,
  },
}
