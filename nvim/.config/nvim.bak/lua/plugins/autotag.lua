return {
	"windwp/nvim-ts-autotag",
	lazy = true,
	config = function()
		require("nvim-ts-autotag").setup()
	end,
	ft = {
		"html",
		"javascript",
		"typescript",
		"javascriptreact",
		"typescriptreact",
		"svelte",
		"vue",
		"tsx",
		"jsx",
		"rescript",
		"xml",
		"php",
		"markdown",
		"glimmer",
		"handlebars",
		"hbs",
	},
}
