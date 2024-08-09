 return {
    'nvim-tree/nvim-tree.lua',
    cmd = { 'NvimTreeToggle', 'NvimTreeFocus' },
    config = function()
      require('nvim-tree').setup {
        -- Add your preferred settings here
        view = {
          side = 'left',
          width = 30,
          hide_root_folder = false,
        },
        renderer = {
          highlight_git = true,
          icons = {
            show = {
              git = true,
              folder = true,
              file = true,
              folder_arrow = true,
            },
          },
        },
        update_focused_file = {
          enable = true,
          update_cwd = true,
        },
        git = {
          enable = true,
          ignore = false,
        },
      }
    end,
}
