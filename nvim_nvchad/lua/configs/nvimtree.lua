--
-- local options = {
--   sync_root_with_cwd = true,
--   update_focused_file = {
--     enable = true,
--     update_root = false,
--   },
-- }
--
-- -- require("nvim-tree").setup(options)
-- return options

return {
  -- filters = { dotfiles = true },
  -- disable_netrw = true,
  -- hijack_cursor = true,
  -- sync_root_with_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = true,
  },
  -- renderer = {
  --   root_folder_label = false,
  --   highlight_git = true,
  --   indent_markers = { enable = true },
  --   icons = {
  --     glyphs = {
  --       default = "󰈚",
  --       folder = {
  --         default = "",
  --         empty = "",
  --         empty_open = "",
  --         open = "",
  --         symlink = "",
  --       },
  --       git = { unmerged = "" },
  --     },
  --   },
  -- },
}


