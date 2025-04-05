return {
	-- Плагин для инкрементального переименования
	{
		"smjonas/inc-rename.nvim",
		cmd = "IncRename", -- Команда для переименования
		config = true, -- Использовать настройки по умолчанию
	},

	-- Перемещение вперед/назад с использованием квадратных скобок
	{
		"echasnovski/mini.bracketed",
		event = "BufReadPost", -- Загружается после чтения буфера
		config = function()
			local bracketed = require("mini.bracketed")
			bracketed.setup({
				file = { suffix = "" }, -- Настройки для файлов
				window = { suffix = "" }, -- Настройки для окон
				quickfix = { suffix = "" }, -- Настройки для быстрого исправления
				yank = { suffix = "" }, -- Настройки для yank
				treesitter = { suffix = "n" }, -- Настройки для Treesitter
			})
		end,
	},

	-- Улучшенное увеличение/уменьшение значений
	{
		"monaqa/dial.nvim",
		keys = {
			{ "<C-a>", function() return require("dial.map").inc_normal() end, expr = true, desc = "Увеличить значение" },
			{ "<C-x>", function() return require("dial.map").dec_normal() end, expr = true, desc = "Уменьшить значение" },
		},
		config = function()
			local augend = require("dial.augend")
			require("dial.config").augends:register_group({
				default = {
					augend.integer.alias.decimal, -- Десятичные числа
					augend.integer.alias.hex, -- Шестнадцатеричные числа
					augend.date.alias["%Y/%m/%d"], -- Даты в формате ГГГГ/ММ/ДД
					augend.constant.alias.bool, -- Логические значения (true/false)
					augend.semver.alias.semver, -- Семантические версии
					augend.constant.new({ elements = { "let", "const" } }), -- Константы let/const
				},
			})
		end,
	},

	-- Плагин Copilot для автодополнения
	{
		"zbirenbaum/copilot.lua",
		opts = {
			suggestion = {
				auto_trigger = true, -- Автоматическое предложение
				keymap = {
					accept = "<C-l>", -- Принять предложение
					accept_word = "<M-l>", -- Принять слово
					accept_line = "<M-S-l>", -- Принять строку
					next = "<M-]>", -- Следующее предложение
					prev = "<M-[>", -- Предыдущее предложение
					dismiss = "<C-]>", -- Отклонить предложение
				},
			},
			filetypes = {
				markdown = true, -- Включить для Markdown
				help = true, -- Включить для файлов справки
			},
		},
	},
}
