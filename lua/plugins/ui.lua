return {
	-- Плагин для сообщений, командной строки и всплывающего меню
	{
		"folke/noice.nvim",
		opts = function(_, opts)
			-- Добавляем маршрут для фильтрации определенных уведомлений
			table.insert(opts.routes, {
				filter = {
					event = "notify", -- Фильтруем события уведомлений
					find = "No information available", -- Текст уведомления для фильтрации
				},
				opts = { skip = true }, -- Пропускаем такие уведомления
			})

			-- Переменная для отслеживания фокуса окна Neovim
			local focused = true
			vim.api.nvim_create_autocmd("FocusGained", {
				callback = function()
					focused = true -- Устанавливаем фокус в true при получении фокуса
				end,
			})
			vim.api.nvim_create_autocmd("FocusLost", {
				callback = function()
					focused = false -- Устанавливаем фокус в false при потере фокуса
				end,
			})

			-- Добавляем маршрут для обработки уведомлений, когда окно не в фокусе
			table.insert(opts.routes, 1, {
				filter = {
					cond = function()
						return not focused -- Условие: окно не в фокусе
					end,
				},
				view = "notify_send", -- Используем определенный вид для уведомлений
				opts = { stop = false }, -- Не останавливаем дальнейшую обработку
			})

			-- Определяем пользовательские команды для плагина
			opts.commands = {
				all = {
					-- Опции для истории сообщений, доступной через `:Noice`
					view = "split", -- Отображаем в отдельном окне
					opts = { enter = true, format = "details" }, -- Входим в окно и форматируем детали
					filter = {}, -- Без фильтра
				},
			}

			-- Автоматически настраиваем тип файла markdown для Noice
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "markdown", -- Срабатывает для файлов markdown
				callback = function(event)
					vim.schedule(function()
						require("noice.text.markdown").keys(event.buf) -- Настраиваем клавиши для markdown
					end)
				end,
			})

			-- Включаем пресет для границы документации LSP
			opts.presets.lsp_doc_border = true
		end,
	},

	-- Плагин для уведомлений с настройкой времени отображения
	{
		"rcarriga/nvim-notify",
		opts = {
			timeout = 5000, -- Устанавливаем время отображения уведомлений на 5 секунд
		},
	},

	-- Плагин для плавной прокрутки
	{
		"snacks.nvim",
		opts = {
			scroll = { enabled = false }, -- Отключаем функцию прокрутки
		},
		keys = {}, -- Не определяем горячие клавиши
	},

	-- Плагин для управления вкладками (buffer line)
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy", -- Загружается лениво
		keys = {
			{ "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Следующая вкладка" }, -- Горячая клавиша для следующей вкладки
			{ "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Предыдущая вкладка" }, -- Горячая клавиша для предыдущей вкладки
		},
		opts = {
			options = {
				mode = "tabs", -- Режим вкладок
				-- separator_style = "slant", -- Стиль разделителя (закомментировано)
				show_buffer_close_icons = false, -- Не показывать иконки закрытия буфера
				show_close_icon = false, -- Не показывать иконку закрытия
			},
		},
	},

	-- Плагин для отображения имени файла
	{
		"b0o/incline.nvim",
		dependencies = { "craftzdog/solarized-osaka.nvim" },
		event = "BufReadPre", -- Срабатывает перед чтением буфера
		priority = 1200, -- Приоритет загрузки
		config = function()
			local colors = require("solarized-osaka.colors").setup()
			require("incline").setup({
				highlight = {
					groups = {
						InclineNormal = { guibg = colors.magenta500, guifg = colors.base04 }, -- Цвета для активного окна
						InclineNormalNC = { guifg = colors.violet500, guibg = colors.base03 }, -- Цвета для неактивного окна
					},
				},
				window = { margin = { vertical = 0, horizontal = 1 } }, -- Отступы окна
				hide = {
					cursorline = true, -- Скрывать при включенной строке курсора
				},
				render = function(props)
					local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t") -- Получаем имя файла
					if vim.bo[props.buf].modified then
						filename = "[+] " .. filename -- Добавляем индикатор изменений
					end

					local icon, color = require("nvim-web-devicons").get_icon_color(filename) -- Получаем иконку и цвет
					return { { icon, guifg = color }, { " " }, { filename } } -- Возвращаем отформатированное имя файла
				end,
			})
		end,
	},

	-- Плагин для строки состояния
	{
		"nvim-lualine/lualine.nvim",
		opts = function(_, opts)
			local LazyVim = require("lazyvim.util")
			opts.sections.lualine_c[4] = {
				LazyVim.lualine.pretty_path({
					length = 0, -- Длина пути
					relative = "cwd", -- Относительный путь от текущей директории
					modified_hl = "MatchParen", -- Подсветка измененных файлов
					directory_hl = "", -- Подсветка директорий
					filename_hl = "Bold", -- Подсветка имени файла
					modified_sign = "", -- Знак изменений
					readonly_icon = " 󰌾 ", -- Иконка для файлов только для чтения
				}),
			}
		end,
	},

	-- Плагин для режима Zen
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode", -- Команда для активации
		opts = {
			plugins = {
				gitsigns = true, -- Включаем поддержку gitsigns
				tmux = true, -- Включаем поддержку tmux
				kitty = { enabled = false, font = "+2" }, -- Настройка для Kitty
			},
		},
		keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } }, -- Горячая клавиша для Zen Mode
	},

	{
		"MeanderingProgrammer/render-markdown.nvim",
		enabled = false,
	},

	{
		"folke/snacks.nvim",
		opts = {
			dashboard = {
				preset = {
					header = [[
	        ██████╗ ███████╗██╗   ██╗ █████╗ ███████╗██╗     ██╗███████╗███████╗
	        ██╔══██╗██╔════╝██║   ██║██╔══██╗██╔════╝██║     ██║██╔════╝██╔════╝
	        ██║  ██║█████╗  ██║   ██║███████║███████╗██║     ██║█████╗  █████╗
	        ██║  ██║██╔══╝  ╚██╗ ██╔╝██╔══██║╚════██║██║     ██║██╔══╝  ██╔══╝
	        ██████╔╝███████╗ ╚████╔╝ ██║  ██║███████║███████╗██║██║     ███████╗
	        ╚═════╝ ╚══════╝  ╚═══╝  ╚═╝  ╚═╝╚══════╝╚══════╝╚═╝╚═╝     ╚══════╝
   ]],
				},
			},
		},
	},
}
