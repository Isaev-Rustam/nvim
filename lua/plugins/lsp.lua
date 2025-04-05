return {
	-- Инструменты
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			-- Добавляем дополнительные инструменты для установки
			vim.list_extend(opts.ensure_installed, {
				"stylua", -- Форматирование Lua
				"selene", -- Линтер для Lua
				"luacheck", -- Линтер для Lua
				"shellcheck", -- Линтер для Shell
				"shfmt", -- Форматирование Shell
				"tailwindcss-language-server", -- Сервер для Tailwind CSS
				"typescript-language-server", -- Сервер для TypeScript
				"css-lsp", -- Сервер для CSS
			})
		end,
	},

	-- Настройки серверов LSP
	{
		"neovim/nvim-lspconfig",
		opts = {
			inlay_hints = { enabled = false }, -- Отключаем встроенные подсказки
			---@type lspconfig.options
			servers = {
				cssls = {}, -- Сервер для CSS
				tailwindcss = {
					root_dir = function(...)
						return require("lspconfig.util").root_pattern(".git")(...) -- Определяем корневую директорию
					end,
				},
				tsserver = {
					root_dir = function(...)
						return require("lspconfig.util").root_pattern(".git")(...) -- Определяем корневую директорию
					end,
					single_file_support = false, -- Отключаем поддержку одиночных файлов
					settings = {
						typescript = {
							inlayHints = {
								includeInlayParameterNameHints = "literal", -- Подсказки для имен параметров
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayFunctionParameterTypeHints = true, -- Подсказки для типов параметров функций
								includeInlayVariableTypeHints = false, -- Отключаем подсказки для типов переменных
								includeInlayPropertyDeclarationTypeHints = true, -- Подсказки для типов свойств
								includeInlayFunctionLikeReturnTypeHints = true, -- Подсказки для типов возвращаемых значений функций
								includeInlayEnumMemberValueHints = true, -- Подсказки для значений членов перечислений
							},
						},
						javascript = {
							inlayHints = {
								includeInlayParameterNameHints = "all", -- Подсказки для всех параметров
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayFunctionParameterTypeHints = true, -- Подсказки для типов параметров функций
								includeInlayVariableTypeHints = true, -- Подсказки для типов переменных
								includeInlayPropertyDeclarationTypeHints = true, -- Подсказки для типов свойств
								includeInlayFunctionLikeReturnTypeHints = true, -- Подсказки для типов возвращаемых значений функций
								includeInlayEnumMemberValueHints = true, -- Подсказки для значений членов перечислений
							},
						},
					},
				},
				html = {}, -- Сервер для HTML
				yamlls = {
					settings = {
						yaml = {
							keyOrdering = false, -- Отключаем сортировку ключей
						},
					},
				},
				lua_ls = {
					single_file_support = true, -- Включаем поддержку одиночных файлов
					settings = {
						Lua = {
							workspace = {
								checkThirdParty = false, -- Отключаем проверку сторонних библиотек
							},
							completion = {
								workspaceWord = true, -- Включаем автодополнение для слов в рабочей области
								callSnippet = "Both", -- Включаем сниппеты для вызовов функций
							},
							hint = {
								enable = true, -- Включаем подсказки
								setType = false, -- Отключаем подсказки для типов
								paramType = true, -- Включаем подсказки для типов параметров
								paramName = "Disable", -- Отключаем подсказки для имен параметров
								semicolon = "Disable", -- Отключаем подсказки для точек с запятой
								arrayIndex = "Disable", -- Отключаем подсказки для индексов массивов
							},
							diagnostics = {
								disable = { "incomplete-signature-doc", "trailing-space" }, -- Отключаем определенные диагностики
								groupSeverity = {
									strong = "Warning", -- Устанавливаем уровень серьезности для группы strong
									strict = "Warning", -- Устанавливаем уровень серьезности для группы strict
								},
								unusedLocalExclude = { "_*" }, -- Исключаем локальные переменные, начинающиеся с "_"
							},
							format = {
								enable = false, -- Отключаем форматирование
								defaultConfig = {
									indent_style = "space", -- Используем пробелы для отступов
									indent_size = "2", -- Размер отступа - 2 пробела
									continuation_indent_size = "2", -- Размер отступа для продолжения строки
								},
							},
						},
					},
				},
			},
			setup = {}, -- Дополнительные настройки
		},
	},
	{
		"neovim/nvim-lspconfig",
		opts = function()
			local keys = require("lazyvim.plugins.lsp.keymaps").get()
			vim.list_extend(keys, {
				{
					"gd",
					function()
						-- Не использовать повторно окно
						require("telescope.builtin").lsp_definitions({ reuse_win = false })
					end,
					desc = "Перейти к определению",
					has = "definition",
				},
			})
		end,
	},
}
