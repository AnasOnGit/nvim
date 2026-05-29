-- ~/.config/nvim/lua/custom/autocmds.lua

vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    if vim.fn.argc() == 0 and vim.fn.bufname() == '' then
      local root = vim.fn.systemlist('git rev-parse --show-toplevel')[1] or vim.loop.cwd()
      Snacks.explorer { cwd = root }

      vim.schedule(function() vim.cmd 'bdelete #' end)
    end
  end,
})
