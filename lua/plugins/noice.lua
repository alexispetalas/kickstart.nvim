return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  opts = {
    notify = {
      enabled = true,
      view = "mini",
    },
    routes = {
      {
        filter = { event = "notify" },
        view = "mini",
      },
    },
  },
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
}
