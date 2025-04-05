return {
    -- Плагин для работы с Playground в nvim-treesitter
    { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },

    -- Основной плагин nvim-treesitter для подсветки синтаксиса и других функций
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            -- Указываем языки, которые должны быть установлены
            ensure_installed = {
                "css", -- CSS
                "gitignore", -- Gitignore
                "graphql", -- GraphQL
                "http", -- HTTP
                "java", -- Java
                "scss", -- SCSS
                "sql", -- SQL
            },

            -- Линтер для запросов Treesitter
            query_linter = {
                enable = true, -- Включаем линтер
                use_virtual_text = true, -- Используем виртуальный текст для ошибок
                lint_events = { "BufWrite", "CursorHold" }, -- События для запуска линтера
            },

            -- Настройка Playground для Treesitter
            playground = {
                enable = true, -- Включаем Playground
                disable = {}, -- Не отключаем ни для каких языков
                updatetime = 25, -- Время обновления подсветки узлов (в мс)
                persist_queries = true, -- Сохраняем запросы между сессиями
                keybindings = { -- Горячие клавиши для Playground
                    toggle_query_editor = "o", -- Переключение редактора запросов
                    toggle_hl_groups = "i", -- Переключение групп подсветки
                    toggle_injected_languages = "t", -- Переключение встроенных языков
                    toggle_anonymous_nodes = "a", -- Переключение анонимных узлов
                    toggle_language_display = "I", -- Переключение отображения языков
                    focus_language = "f", -- Фокус на языке
                    unfocus_language = "F", -- Снятие фокуса с языка
                    update = "R", -- Обновление
                    goto_node = "<cr>", -- Переход к узлу
                    show_help = "?", -- Показать справку
                },
            },
        },
        config = function(_, opts)
            -- Настраиваем nvim-treesitter с переданными опциями
            require("nvim-treesitter.configs").setup(opts)

            -- Добавляем поддержку MDX
            vim.filetype.add({
                extension = {
                    mdx = "mdx", -- Ассоциация для файлов .mdx
                },
            })
            vim.treesitter.language.register("markdown", "mdx") -- Регистрируем MDX как Markdown
        end,
    },
}
