return {
  {
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory', 'DiffviewClose' },
    keys = {
      { '<Leader>gvo', ':DiffviewOpen<CR>', desc = 'Git diff view' },
      { '<Leader>gvh', ':DiffviewFileHistory %<CR>', desc = 'Git file history' },
      { '<Leader>gvl', ':DiffviewFileHistory<CR>', desc = 'Git repo history' },
      { '<Leader>gvq', ':DiffviewClose<CR>', desc = 'Close diffview' },
    },
    config = function()
      require('diffview').setup({
        enhanced_diff_hl = true,
        view = {
          default = {
            layout = 'diff2_horizontal',
            disable_diagnostics = true,
          },
          file_history = {
            layout = 'diff2_horizontal',
            disable_diagnostics = true,
          },
        },
        file_panel = {
          listing_style = 'tree',
          win_config = {
            position = 'left',
            width = 35,
          },
        },
        hooks = {
          diff_buf_read = function(_)
            vim.opt_local.wrap = false
            vim.opt_local.list = false
          end,
        },
      })
    end,
  },
}
