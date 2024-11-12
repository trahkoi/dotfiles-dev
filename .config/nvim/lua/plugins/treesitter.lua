return {
	'nvim-treesitter/nvim-treesitter',
	build = ':TSUpdate',
	main = 'nvim-treesitter.configs',
	opts = {
		ensure_installed = { 'bash', 'lua', 'markdown', 'markdown_inline', 'c_sharp' },
		auto_install = true,
		highlight = {
			enable = true,
		},
		indent = { enable = true }
	},
}
