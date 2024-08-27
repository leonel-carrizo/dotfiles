local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    c = { "42norm_format" },
  },
  formatters = {
    ["42norm_format"] = {
      inherit = false,
      command = "42norm_format",
      args = { vim.fn.expand "%:p" },
	  stdin = false,
    },
  },
  -- format_on_save = {
  -- These options will be passed to conform.format()
  -- timeout_ms = 500,
  -- lsp_fallback = true,
  -- },
}

require("conform").setup(options)
