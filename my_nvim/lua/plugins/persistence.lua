return {

	-- Session management. This saves your session in the background,
	-- keeping track of open buffers, window arrangement, and more.
	-- You can restore sessions when returning through the dashboard.
	{
	  "folke/persistence.nvim",
	  event = "BufReadPre",
	  opts = {},
	  -- stylua: ignore
	  keys = {
		{ "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
		{ "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
		{ "<leader>qS", function() require("persistence").select() end, desc = "Select a session to restore"},
		{ "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
	  },
	},
  }