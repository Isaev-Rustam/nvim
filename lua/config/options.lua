-- Устанавливаем лидера клавиш
vim.g.mapleader = " "

-- Кодировка
vim.opt.encoding = "utf-8" -- Устанавливаем кодировку UTF-8
vim.opt.fileencoding = "utf-8" -- Кодировка файлов UTF-8

-- Нумерация строк
vim.opt.number = true -- Включаем отображение номеров строк

-- Общие настройки
vim.opt.title = true -- Показывать заголовок окна
vim.opt.autoindent = true -- Автоматический отступ
vim.opt.smartindent = true -- Умный отступ
vim.opt.hlsearch = true -- Подсвечивать результаты поиска
vim.opt.backup = false -- Отключить резервное копирование
vim.opt.showcmd = true -- Показывать вводимые команды
vim.opt.cmdheight = 1 -- Высота командной строки
vim.opt.laststatus = 3 -- Глобальная строка состояния
vim.opt.expandtab = true -- Преобразовывать табуляцию в пробелы
vim.opt.scrolloff = 10 -- Отступ при прокрутке
vim.opt.shell = "fish" -- Устанавливаем shell на fish
vim.opt.backupskip = { "/tmp/*", "/private/tmp/*" } -- Исключения для резервного копирования
vim.opt.inccommand = "split" -- Инкрементальное отображение команд
vim.opt.ignorecase = true -- Игнорировать регистр при поиске
vim.opt.smarttab = true -- Умная табуляция
vim.opt.breakindent = true -- Сохранять отступы при переносе строк
vim.opt.shiftwidth = 2 -- Размер отступа
vim.opt.tabstop = 2 -- Размер табуляции
vim.opt.wrap = false -- Отключить перенос строк
vim.opt.backspace = { "start", "eol", "indent" } -- Настройки клавиши Backspace
vim.opt.path:append({ "**" }) -- Поиск файлов в подкаталогах
vim.opt.wildignore:append({ "*/node_modules/*" }) -- Игнорировать папку node_modules
vim.opt.splitbelow = true -- Новые окна открываются снизу
vim.opt.splitright = true -- Новые окна открываются справа
vim.opt.splitkeep = "cursor" -- Сохранять положение курсора при разделении окна
vim.opt.mouse = "" -- Отключить использование мыши

-- Подчеркивание
vim.cmd([[let &t_Cs = "\e[4:3m"]]) -- Включить подчеркивание
vim.cmd([[let &t_Ce = "\e[4:0m"]]) -- Отключить подчеркивание

-- Добавление звездочек в блочные комментарии
vim.opt.formatoptions:append({ "r" })


-- Настройки для Neovim версии 0.8 и выше
if vim.fn.has("nvim-0.8") == 1 then
    vim.opt.cmdheight = 0 -- Устанавливаем высоту командной строки в 0
end

-- Типы файлов
vim.filetype.add({
    extension = {
        mdx = "mdx", -- Ассоциация для файлов .mdx
    },
})

-- Глобальные переменные LazyVim
vim.g.lazyvim_prettier_needs_config = true -- Указывает, что Prettier требует конфигурации
vim.g.lazyvim_picker = "telescope" -- Устанавливаем Telescope как инструмент выбора
vim.g.lazyvim_cmp = "blink.cmp" -- Устанавливаем Blink CMP
