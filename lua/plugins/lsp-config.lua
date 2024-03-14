return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "gopls", "tsserver", "volar" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")
			lspconfig.eslint.setup({
				settings = { packageManager = "npm" },
				on_attach = function(client, bufnr)
				  vim.api.nvim_create_autocmd("BufWritePre", {
				    buffer = bufnr,
				    command = "EslintFixAll",
				  })
				end,
			})
			lspconfig.lua_ls.setup({ capabilities = capabilities })
			lspconfig.tsserver.setup({
				capabilities = capabilities,
				init_options = { preferences = { disableSuggestions = true } },
			})
			lspconfig.gopls.setup({ capabilities = capabilities })
			lspconfig.volar.setup({
				filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
				init_options = {
					typescript = {
						serverPath = "/home/motz/.nvm/versions/node/v21.7.1/lib/node_modules/typescript/lib/tsserverlib.js",
					},
				},
			})

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>d", vim.lsp.buf.definition, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
