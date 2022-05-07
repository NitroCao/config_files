-- Bubbles config for lualine
-- Author: lokesh-krishna
-- MIT license, see LICENSE for more details.

-- stylua: ignore
local colors = {
  blue   = '#80a0ff',
  cyan   = '#79dac8',
  black  = '#080808',
  white  = '#c6c6c6',
  red    = '#ff5189',
  violet = '#d183e8',
  grey   = '#303030',
}

local bubbles_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.violet },
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.black, bg = colors.black },
  },

  insert = { a = { fg = colors.black, bg = colors.blue } },
  visual = { a = { fg = colors.black, bg = colors.cyan } },
  replace = { a = { fg = colors.black, bg = colors.red } },

  inactive = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.black, bg = colors.black },
  },
}

require('lualine').setup({
  options = {
    theme = 'auto',
    icons_enabled = true,
    component_separators = '|',
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = {
      { 'mode', separator = { left = '', right = '' }, right_padding = 2 },
    },
    lualine_b = { 'filename', 'branch', 'b:coc_current_function', {
        'diagnostics',
        sources = { 'coc' },
        symbols = { error = ' ', warn = ' ', info = ' ' },
        diagnostics_color = {
            color_error = { fg = '#ec5f67' },
            color_warn = { fg = '#ECBE7B' },
            color_info = { fg = '#008080' },
        },
        left_padding = 8,
    }},
    lualine_c = {},
    lualine_x = {},
    lualine_y = { 'filetype', 'fileformat', 'encoding', 'progress' },
    lualine_z = {
      { 'location', separator = { left = '', right = '' }, left_padding = 2 },
    },
  },
  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'location' },
  },
  tabline = {},
  extensions = {},
})
