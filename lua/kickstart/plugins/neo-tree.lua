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
      follow_current_file = true, -- This will follow the current file in the tree
      window = {
        mappings = {
          ['|'] = 'close_window',
          ['Z'] = 'expand_all_nodes',
        },
      },
    },
  },
}
