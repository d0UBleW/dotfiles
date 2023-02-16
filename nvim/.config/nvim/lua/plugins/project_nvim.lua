return {
	{
		"ahmedkhalf/project.nvim",
		opts = {
			silent_chdir = true,
			scope_chdir = "tab",
		},
		config = function(_, opts)
			require("project_nvim").setup(opts)
		end,
	},
}
