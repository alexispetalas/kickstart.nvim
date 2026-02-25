vim.api.nvim_create_autocmd('FileType', {
  desc = 'Set 2-space indentation for TypeScript files',
  group = vim.api.nvim_create_augroup('typescript-indent', { clear = true }),
  pattern = { 'typescript', 'typescriptreact' },
  callback = function()
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
  end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})
