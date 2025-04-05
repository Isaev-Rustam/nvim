local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- Последний стабильный релиз
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = {
        -- Добавляем LazyVim и импортируем его плагины
        {
            "LazyVim/LazyVim",
            import = "lazyvim.plugins",
            opts = {
                colorscheme = "solarized-osaka", -- Устанавливаем цветовую схему
                news = {
                    lazyvim = true, -- Новости LazyVim
                    neovim = true, -- Новости Neovim
                },
            },
        },
        -- Импорт дополнительных модулей
        { import = "lazyvim.plugins.extras.linting.eslint" }, -- Поддержка ESLint
        { import = "lazyvim.plugins.extras.formatting.prettier" }, -- Поддержка Prettier
        { import = "lazyvim.plugins.extras.lang.typescript" }, -- Поддержка TypeScript
        { import = "lazyvim.plugins.extras.lang.json" }, -- Поддержка JSON
        -- { import = "lazyvim.plugins.extras.lang.markdown" }, -- Поддержка Markdown (закомментировано)
        { import = "lazyvim.plugins.extras.lang.tailwind" }, -- Поддержка Tailwind CSS
        { import = "lazyvim.plugins.extras.util.mini-hipatterns" }, -- Поддержка mini-hipatterns
        { import = "plugins" }, -- Импорт пользовательских плагинов
    },
    defaults = {
        -- По умолчанию только плагины LazyVim будут загружаться лениво. Ваши пользовательские плагины будут загружаться при старте.
        -- Если вы знаете, что делаете, вы можете установить это значение в `true`, чтобы все пользовательские плагины загружались лениво.
        lazy = false,
        -- Рекомендуется оставить version=false, так как многие плагины с поддержкой версий имеют устаревшие релизы,
        -- которые могут сломать вашу установку Neovim.
        version = false, -- Всегда использовать последнюю версию из git
        -- version = "*", -- Попробовать установить последнюю стабильную версию для плагинов с поддержкой semver
    },
    dev = {
        path = "~/.ghq/github.com", -- Путь для разработки плагинов
    },
    checker = { enabled = true }, -- Автоматически проверять обновления плагинов
    performance = {
        cache = {
            enabled = true, -- Включить кэширование
            -- disable_events = {}, -- Отключить события (если нужно)
        },
        rtp = {
            -- Отключить некоторые плагины rtp
            disabled_plugins = {
                "gzip", -- Отключить поддержку gzip
                "netrwPlugin", -- Отключить netrw
                "rplugin", -- Отключить rplugin
                "tarPlugin", -- Отключить tarPlugin
                "tohtml", -- Отключить tohtml
                "tutor", -- Отключить tutor
                "zipPlugin", -- Отключить zipPlugin
            },
        },
    },
    ui = {
        custom_keys = {
            ["<localleader>d"] = function(plugin)
                dd(plugin) -- Пример пользовательской команды
            end,
        },
    },
    debug = false, -- Отключить режим отладки
})
