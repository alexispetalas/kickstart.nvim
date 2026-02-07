local function ivy(opts)
  return require('telescope.themes').get_ivy(vim.tbl_extend('force', {
    winblend = 10,
    previewer = false,
  }, opts or {}))
end

return {
  'nvim-telescope/telescope.nvim',
  cmd = 'Telescope',
  keys = {
    -- Core pickers (themed)
    {
      '<leader>sf',
      function()
        require('telescope.builtin').find_files()
      end,
      desc = '[S]earch [F]iles',
    },
    {
      '<leader>sg',
      function()
        require('telescope.builtin').live_grep()
      end,
      desc = '[S]earch by [G]rep',
    },
    {
      '<leader>sw',
      function()
        require('telescope.builtin').grep_string(ivy())
      end,
      desc = '[S]earch current [W]ord',
    },
    {
      '<leader>sd',
      function()
        require('telescope.builtin').diagnostics(ivy())
      end,
      desc = '[S]earch [D]iagnostics',
    },
    {
      '<leader><leader>',
      function()
        require('telescope.builtin').buffers()
      end,
      desc = '[ ] Find existing buffers',
    },
    {
      '<leader>/',
      function()
        require('telescope.builtin').current_buffer_fuzzy_find(ivy())
      end,
      desc = '[/] Fuzzily search in current buffer',
    },

    -- Core pickers
    {
      '<leader>sh',
      function()
        require('telescope.builtin').help_tags()
      end,
      desc = '[S]earch [H]elp',
    },
    {
      '<leader>sk',
      function()
        require('telescope.builtin').keymaps()
      end,
      desc = '[S]earch [K]eymaps',
    },
    {
      '<leader>ss',
      function()
        require('telescope.builtin').builtin()
      end,
      desc = '[S]earch [S]elect Telescope',
    },
    {
      '<leader>sr',
      function()
        require('telescope.builtin').resume()
      end,
      desc = '[S]earch [R]esume',
    },
    {
      '<leader>s.',
      function()
        require('telescope.builtin').oldfiles()
      end,
      desc = '[S]earch Recent Files',
    },
    {
      '<leader>s/',
      function()
        require('telescope.builtin').live_grep { grep_open_files = true, prompt_title = 'Live Grep in Open Files' }
      end,
      desc = '[S]earch [/] in Open Files',
    },
    {
      '<leader>sn',
      function()
        require('telescope.builtin').find_files { cwd = vim.fn.stdpath 'config' }
      end,
      desc = '[S]earch [N]eovim files',
    },

    -- File operations
    {
      '<leader>fb',
      function()
        require('telescope').extensions.file_browser.file_browser()
      end,
      desc = 'File browser',
    },
    {
      '<leader>fB',
      function()
        require('telescope').extensions.file_browser.file_browser { path = vim.fn.expand '%:p:h', select_buffer = true }
      end,
      desc = 'File browser (current dir)',
    },
    {
      '<leader>fc',
      function()
        require('telescope.builtin').colorscheme()
      end,
      desc = 'Colorscheme',
    },
    {
      '<leader>fC',
      function()
        require('telescope.builtin').commands()
      end,
      desc = 'Commands',
    },
    {
      '<leader>fh',
      function()
        require('telescope.builtin').command_history()
      end,
      desc = 'Command History',
    },
    {
      '<leader>fH',
      function()
        require('telescope.builtin').help_tags()
      end,
      desc = 'Help Tags',
    },
    {
      '<leader>fm',
      function()
        require('telescope.builtin').man_pages()
      end,
      desc = 'Man Pages',
    },
    {
      '<leader>fM',
      function()
        require('telescope.builtin').marks()
      end,
      desc = 'Marks',
    },
    {
      '<leader>fq',
      function()
        require('telescope.builtin').quickfix()
      end,
      desc = 'Quickfix',
    },
    {
      '<leader>fQ',
      function()
        require('telescope.builtin').quickfixhistory()
      end,
      desc = 'Quickfix History',
    },
    {
      '<leader>fr',
      function()
        require('telescope.builtin').registers()
      end,
      desc = 'Registers',
    },
    {
      '<leader>ft',
      function()
        require('telescope.builtin').filetypes()
      end,
      desc = 'File Types',
    },

    -- Search operations
    {
      '<leader>sa',
      function()
        require('telescope.builtin').autocommands()
      end,
      desc = '[S]earch [A]utocommands',
    },
    {
      '<leader>sb',
      function()
        require('telescope.builtin').current_buffer_fuzzy_find()
      end,
      desc = '[S]earch in current [B]uffer',
    },
    {
      '<leader>sc',
      function()
        require('telescope.builtin').commands()
      end,
      desc = '[S]earch [C]ommands',
    },
    {
      '<leader>sC',
      function()
        require('telescope.builtin').command_history()
      end,
      desc = '[S]earch [C]ommand history',
    },
    {
      '<leader>se',
      function()
        require('telescope').extensions.symbols.symbols()
      end,
      desc = '[S]earch symbols',
    },
    {
      '<leader>sj',
      function()
        require('telescope.builtin').jumplist()
      end,
      desc = '[S]earch [J]umplist',
    },
    {
      '<leader>sl',
      function()
        require('telescope.builtin').loclist()
      end,
      desc = '[S]earch [L]ocation list',
    },
    {
      '<leader>sm',
      function()
        require('telescope.builtin').keymaps()
      end,
      desc = '[S]earch key[M]aps',
    },
    {
      '<leader>sM',
      function()
        require('telescope.builtin').man_pages()
      end,
      desc = '[S]earch [M]an pages',
    },
    {
      '<leader>so',
      function()
        require('telescope.builtin').vim_options()
      end,
      desc = '[S]earch vim [O]ptions',
    },
    {
      '<leader>sR',
      function()
        require('telescope.builtin').registers()
      end,
      desc = '[S]earch [R]egisters',
    },
    {
      '<leader>st',
      function()
        require('telescope').extensions.live_grep_args.live_grep_args()
      end,
      desc = '[S]earch [T]ext with args',
    },
    {
      '<leader>sT',
      function()
        require('telescope.builtin').treesitter()
      end,
      desc = '[S]earch [T]reesitter symbols',
    },
    {
      '<leader>sy',
      function()
        require('telescope.builtin').filetypes()
      end,
      desc = '[S]earch file t[Y]pes',
    },

    -- Git operations
    {
      '<leader>sGb',
      function()
        require('telescope.builtin').git_branches()
      end,
      desc = '[S]earch [G]it [B]ranches',
    },
    {
      '<leader>sGc',
      function()
        require('telescope.builtin').git_commits()
      end,
      desc = '[S]earch [G]it [C]ommits',
    },
    {
      '<leader>sGC',
      function()
        require('telescope.builtin').git_bcommits()
      end,
      desc = '[S]earch [G]it buffer [C]ommits',
    },
    {
      '<leader>sGs',
      function()
        require('telescope.builtin').git_status()
      end,
      desc = '[S]earch [G]it [S]tatus',
    },
    {
      '<leader>sGt',
      function()
        require('telescope.builtin').git_stash()
      end,
      desc = '[S]earch [G]it s[T]ash',
    },

    -- LSP operations
    {
      '<leader>sld',
      function()
        require('telescope.builtin').diagnostics()
      end,
      desc = '[S]earch [L]SP [D]iagnostics',
    },
    {
      '<leader>sls',
      function()
        require('telescope.builtin').lsp_document_symbols()
      end,
      desc = '[S]earch [L]SP document [S]ymbols',
    },
    {
      '<leader>slS',
      function()
        require('telescope.builtin').lsp_workspace_symbols()
      end,
      desc = '[S]earch [L]SP workspace [S]ymbols',
    },
    {
      '<leader>slr',
      function()
        require('telescope.builtin').lsp_references()
      end,
      desc = '[S]earch [L]SP [R]eferences',
    },
    {
      '<leader>sli',
      function()
        require('telescope.builtin').lsp_implementations()
      end,
      desc = '[S]earch [L]SP [I]mplementations',
    },
    {
      '<leader>slt',
      function()
        require('telescope.builtin').lsp_type_definitions()
      end,
      desc = '[S]earch [L]SP [T]ype definitions',
    },

    -- Project management
    {
      '<leader>pp',
      function()
        require('telescope').extensions.project.project()
      end,
      desc = 'Switch [P]roject',
    },
    {
      '<leader>pr',
      function()
        require('telescope.builtin').oldfiles { cwd_only = true }
      end,
      desc = '[P]roject [R]ecent files',
    },
    {
      '<leader>pf',
      function()
        require('telescope.builtin').find_files { cwd_only = true }
      end,
      desc = '[P]roject [F]iles',
    },
    {
      '<leader>pg',
      function()
        require('telescope.builtin').live_grep { cwd_only = true }
      end,
      desc = '[P]roject [G]rep',
    },

    -- Undo
    {
      '<leader>u',
      function()
        require('telescope').extensions.undo.undo()
      end,
      desc = 'Undo history',
    },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    { 'nvim-telescope/telescope-file-browser.nvim' },
    { 'nvim-telescope/telescope-live-grep-args.nvim', version = '^1.0.0' },
    { 'nvim-telescope/telescope-project.nvim' },
    { 'nvim-telescope/telescope-symbols.nvim' },
    { 'debugloop/telescope-undo.nvim' },
  },
  config = function()
    require('telescope').setup {
      defaults = {
        layout_strategy = 'center',
        layout_config = {
          anchor = 'N',
          mirror = true,
          prompt_position = 'top',
          width = 0.9,
          height = 0.4,
        },
        winblend = 10,
        previewer = true,
        sorting_strategy = 'ascending',
        border = true,
      },
      extensions = {
        file_browser = {
          hijack_netrw = true,
        },
        live_grep_args = {
          auto_quoting = true,
        },
        project = {
          base_dirs = {
            { '~/code', max_depth = 2 },
            { '~/.config', max_depth = 1 },
          },
          hidden_files = false,
        },
        undo = {
          use_delta = true,
          side_by_side = false,
        },
      },
    }

    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')
    pcall(require('telescope').load_extension, 'file_browser')
    pcall(require('telescope').load_extension, 'live_grep_args')
    pcall(require('telescope').load_extension, 'project')
    pcall(require('telescope').load_extension, 'symbols')
    pcall(require('telescope').load_extension, 'undo')
  end,
}
