-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = true,
  --  config = function()
  --    require('neo-tree').setup {
  --      source_selector = {
  --        winbar = false,
  --        statusline = false,
  --      },
  --    }
  --  end,
  keys = {
    { '|', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    filesystem = {
      follow_current_file = {
        enabled = true, -- This will enable the feature
        leave_dirs_open = false, -- This will close the directories that are not in the path of the current file
      },
      use_libuv_file_watcher = true, -- Auto-refresh on filesystem changes
      window = {
        mappings = {
          ['|'] = 'close_window',
          ['Z'] = 'expand_all_nodes',
        },
      },
    },
  },
}
