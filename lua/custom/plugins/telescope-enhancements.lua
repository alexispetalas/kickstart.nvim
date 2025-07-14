-- Enhanced Telescope configuration with additional pickers and functionality

return {
  -- Additional Telescope extensions
  {
    'nvim-telescope/telescope-file-browser.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
  },
  
  {
    'nvim-telescope/telescope-live-grep-args.nvim',
    version = '^1.0.0',
    dependencies = { 'nvim-telescope/telescope.nvim' },
  },
  
  {
    'nvim-telescope/telescope-project.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
  },
  
  {
    'nvim-telescope/telescope-symbols.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
  },
  
  {
    'debugloop/telescope-undo.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    keys = {
      {
        '<leader>u',
        '<cmd>Telescope undo<cr>',
        desc = 'Undo history',
      },
    },
    config = function()
      require('telescope').load_extension 'undo'
    end,
  },

  -- Additional keymaps for telescope extensions
  {
    'nvim-telescope/telescope.nvim',
    keys = {
      -- File operations
      { '<leader>fb', '<cmd>Telescope file_browser<cr>', desc = 'File browser' },
      { '<leader>fB', '<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>', desc = 'File browser (current dir)' },
      { '<leader>fc', '<cmd>Telescope colorscheme<cr>', desc = 'Colorscheme' },
      { '<leader>fC', '<cmd>Telescope commands<cr>', desc = 'Commands' },
      { '<leader>fh', '<cmd>Telescope command_history<cr>', desc = 'Command History' },
      { '<leader>fH', '<cmd>Telescope help_tags<cr>', desc = 'Help Tags' },
      { '<leader>fm', '<cmd>Telescope man_pages<cr>', desc = 'Man Pages' },
      { '<leader>fM', '<cmd>Telescope marks<cr>', desc = 'Marks' },
      { '<leader>fq', '<cmd>Telescope quickfix<cr>', desc = 'Quickfix' },
      { '<leader>fQ', '<cmd>Telescope quickfixhistory<cr>', desc = 'Quickfix History' },
      { '<leader>fr', '<cmd>Telescope registers<cr>', desc = 'Registers' },
      { '<leader>ft', '<cmd>Telescope filetypes<cr>', desc = 'File Types' },
      
      -- Search operations
      { '<leader>sa', '<cmd>Telescope autocommands<cr>', desc = '[S]earch [A]utocommands' },
      { '<leader>sb', '<cmd>Telescope current_buffer_fuzzy_find<cr>', desc = '[S]earch in current [B]uffer' },
      { '<leader>sc', '<cmd>Telescope commands<cr>', desc = '[S]earch [C]ommands' },
      { '<leader>sC', '<cmd>Telescope command_history<cr>', desc = '[S]earch [C]ommand history' },
      { '<leader>se', '<cmd>Telescope symbols<cr>', desc = '[S]earch [E]mojis/symbols' },
      { '<leader>sj', '<cmd>Telescope jumplist<cr>', desc = '[S]earch [J]umplist' },
      { '<leader>sl', '<cmd>Telescope loclist<cr>', desc = '[S]earch [L]ocation list' },
      { '<leader>sm', '<cmd>Telescope keymaps<cr>', desc = '[S]earch [K]eymaps' },
      { '<leader>sM', '<cmd>Telescope man_pages<cr>', desc = '[S]earch [M]an pages' },
      { '<leader>so', '<cmd>Telescope vim_options<cr>', desc = '[S]earch vim [O]ptions' },
      { '<leader>sR', '<cmd>Telescope registers<cr>', desc = '[S]earch [R]egisters' },
      { '<leader>st', '<cmd>Telescope live_grep_args<cr>', desc = '[S]earch [T]ext with args' },
      { '<leader>sT', '<cmd>Telescope treesitter<cr>', desc = '[S]earch [T]reesitter symbols' },
      { '<leader>sy', '<cmd>Telescope filetypes<cr>', desc = '[S]earch file t[Y]pes' },
      
      -- Git operations
      { '<leader>sgb', '<cmd>Telescope git_branches<cr>', desc = '[S]earch [G]it [B]ranches' },
      { '<leader>sgc', '<cmd>Telescope git_commits<cr>', desc = '[S]earch [G]it [C]ommits' },
      { '<leader>sgC', '<cmd>Telescope git_bcommits<cr>', desc = '[S]earch [G]it buffer [C]ommits' },
      { '<leader>sgs', '<cmd>Telescope git_status<cr>', desc = '[S]earch [G]it [S]tatus' },
      { '<leader>sgt', '<cmd>Telescope git_stash<cr>', desc = '[S]earch [G]it s[T]ash' },
      
      -- LSP operations
      { '<leader>sld', '<cmd>Telescope diagnostics<cr>', desc = '[S]earch [L]SP [D]iagnostics' },
      { '<leader>sls', '<cmd>Telescope lsp_document_symbols<cr>', desc = '[S]earch [L]SP document [S]ymbols' },
      { '<leader>slS', '<cmd>Telescope lsp_workspace_symbols<cr>', desc = '[S]earch [L]SP workspace [S]ymbols' },
      { '<leader>slr', '<cmd>Telescope lsp_references<cr>', desc = '[S]earch [L]SP [R]eferences' },
      { '<leader>sli', '<cmd>Telescope lsp_implementations<cr>', desc = '[S]earch [L]SP [I]mplementations' },
      { '<leader>slt', '<cmd>Telescope lsp_type_definitions<cr>', desc = '[S]earch [L]SP [T]ype definitions' },
      
      -- Project management
      { '<leader>pp', '<cmd>Telescope project<cr>', desc = 'Switch [P]roject' },
      { '<leader>pr', '<cmd>Telescope oldfiles cwd_only=true<cr>', desc = '[P]roject [R]ecent files' },
      { '<leader>pf', '<cmd>Telescope find_files cwd_only=true<cr>', desc = '[P]roject [F]iles' },
      { '<leader>pg', '<cmd>Telescope live_grep cwd_only=true<cr>', desc = '[P]roject [G]rep' },
    },
    config = function()
      -- Only load extensions, don't call setup again
      local telescope = require 'telescope'
      
      -- Load extensions
      pcall(telescope.load_extension, 'file_browser')
      pcall(telescope.load_extension, 'live_grep_args')
      pcall(telescope.load_extension, 'project')
      pcall(telescope.load_extension, 'symbols')
    end,
  },
}