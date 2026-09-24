return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    require('toggleterm').setup {
      open_mapping = [[<c-\>]],
      direction = 'horizontal',
      float_opts = {
        border = 'curved',
      },
      --      winbar = {
      --        enabled = false,
      --        name_formatter = function(term)
      --          return term.name
      --        end,
      --      },
    }
  end,
}
