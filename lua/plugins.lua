return {

	-- ✦ THEME ------------------------------------------------------------------
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd("colorscheme tokyonight")
		end,
	},

	-- ✦ DASHBOARD -------------------------------------------------------------
	{
		"goolord/alpha-nvim",
		lazy = false,
		priority = 1000,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")
			
			-- Set header
			dashboard.section.header.val = {
				[[                               __                ]],
				[[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
				[[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
				[[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
				[[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
				[[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
			}

			-- Set menu
			dashboard.section.buttons.val = {
				dashboard.button("e", "📁  Open Tree", "<cmd>Neotree toggle<cr>"),
				dashboard.button("f", "🔍  Find File", "<cmd>Telescope find_files<cr>"),
				dashboard.button("g", "🔎  Live Grep", "<cmd>Telescope live_grep<cr>"),
				dashboard.button("q", "❌  Quit NVIM", "<cmd>qa<cr>"),
			}

			-- Send config to alpha
			alpha.setup(dashboard.opts)

			-- Disable folding on alpha buffer
			vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
		end,
	},

	-- ✦ TREESITTER -------------------------------------------------------------
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				highlight = { enable = true },
				indent = { enable = true },
				ensure_installed = {
					"lua",
					"tsx",
					"typescript",
					"javascript",
					"json",
					"css",
					"html",
					"markdown",
				},
			})
		end,
	},

	-- ✦ MASON (language-server manager) ---------------------------------------
	{ "williamboman/mason.nvim", build = ":MasonUpdate", opts = {} },
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = "williamboman/mason.nvim",
		opts = {
			ensure_installed = { "lua_ls", "ts_ls", "eslint", "tailwindcss" },
		},
	},

	-- ✦ LSP --------------------------------------------------------------------
	{
		"neovim/nvim-lspconfig",
		dependencies = "williamboman/mason-lspconfig.nvim",
		config = function()
			require("lsp")
		end,
	},

	-- ✦ COMPLETION (no snippets) ----------------------------------------------
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"roobert/tailwindcss-colorizer-cmp.nvim",
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				snippet = { expand = function() end }, -- no snippet engine
				mapping = cmp.mapping.preset.insert({
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = cmp.mapping.complete(),
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "buffer" },
				},
			})
			local ok, tw = pcall(require, "tailwindcss-colorizer-cmp")
			if ok then
				tw.setup()
			end
		end,
	},

	-- ✦ AUTOPAIRS --------------------------------------------------------------
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = { check_ts = true },
		config = function(_, opts)
			local npairs = require("nvim-autopairs")
			npairs.setup(opts)
			local cmp_ok, cmp = pcall(require, "cmp")
			if cmp_ok then
				local cmp_pairs = require("nvim-autopairs.completion.cmp")
				cmp.event:on("confirm_done", cmp_pairs.on_confirm_done())
			end
		end,
	},

	-- ✦ TELESCOPE --------------------------------------------------------------
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		dependencies = "nvim-lua/plenary.nvim",
		opts = { defaults = { file_ignore_patterns = { "node_modules" } } },
	},

	-- ✦ FLOATING NEO-TREE ------------------------------------------------------
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		lazy = true,
		cmd = "Neotree",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		opts = {
			enable_git_status = true,
			enable_diagnostics = true,
			window = {
				position = "float",
				popup = { size = { height = "80%", width = "40%" } },
			},
			event_handlers = {
				{
					event = "file_opened",
					handler = function()
						require("neo-tree.command").execute({ action = "close" })
					end,
				},
			},
		},
	},

	-- ✦ GITSIGNS ---------------------------------------------------------------
	{ "lewis6991/gitsigns.nvim", opts = {} },

	-- ✦ TOGGLETERM (floating lazygit / shell) ----------------------------------
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		opts = { shade_terminals = true, open_mapping = [[<c-\>]], winblend = 3 },
	},

	-- ✦ FORMATTING (Prettier / Stylua) ----------------------------------------
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				javascript = { "prettierd" },
				javascriptreact = { "prettierd" },
				typescript = { "prettierd" },
				typescriptreact = { "prettierd" },
				css = { "prettierd" },
				html = { "prettierd" },
				json = { "prettierd" },
				lua = { "stylua" },
			},
			format_on_save = { timeout_ms = 5000, lsp_fallback = true },
		},
	},

	-- ✦ LUALINE (git diff + diagnostics + path) -------------------------------
	{
		"nvim-lualine/lualine.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = {
			options = { theme = "auto", section_separators = "", component_separators = "" },
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff" },
				lualine_c = { { "filename", path = 1 } },
				lualine_x = { { "diagnostics", sources = { "nvim_diagnostic" } } },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
		},
	},
}
