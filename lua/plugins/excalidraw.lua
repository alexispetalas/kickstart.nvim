return {
  'marcocofano/excalidraw.nvim',
  config = function()
    require('excalidraw').setup {
      storage_dir = '~/code/diagrams',
      templates_dir = '~/code/diagrams/templates',
      open_on_create = true,
      relative_path = true,
      picker = {
        link_scene_mapping = '<C-l>',
      },
    }
  end,
}
