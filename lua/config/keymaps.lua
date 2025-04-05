local discipline = require("craftzdog.discipline")

discipline.cowboy()

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Выполнение действий без изменения регистров
keymap.set("n", "x", '"_x') -- Удалить символ без копирования в регистр
keymap.set("n", "<Leader>p", '"0p') -- Вставить из регистра 0
keymap.set("n", "<Leader>P", '"0P') -- Вставить из регистра 0 перед курсором
keymap.set("v", "<Leader>p", '"0p') -- Вставить из регистра 0 в визуальном режиме
keymap.set("n", "<Leader>c", '"_c') -- Заменить текст без копирования в регистр
keymap.set("n", "<Leader>C", '"_C') -- Заменить до конца строки без копирования
keymap.set("v", "<Leader>c", '"_c') -- Заменить выделенный текст без копирования
keymap.set("v", "<Leader>C", '"_C') -- Заменить выделенный текст до конца строки
keymap.set("n", "<Leader>d", '"_d') -- Удалить текст без копирования в регистр
keymap.set("n", "<Leader>D", '"_D') -- Удалить до конца строки без копирования
keymap.set("v", "<Leader>d", '"_d') -- Удалить выделенный текст без копирования
keymap.set("v", "<Leader>D", '"_D') -- Удалить выделенный текст до конца строки

-- Увеличение/уменьшение числа
keymap.set("n", "+", "<C-a>") -- Увеличить число
keymap.set("n", "-", "<C-x>") -- Уменьшить число

-- Удаление слова назад
keymap.set("n", "dw", 'vb"_d') -- Удалить слово назад без копирования

-- Выделить всё
keymap.set("n", "<C-a>", "gg<S-v>G") -- Выделить весь текст

-- Сохранение с правами root (пока не работает)
-- vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})

-- Отключение продолжений
keymap.set("n", "<Leader>o", "o<Esc>^Da", opts) -- Вставить новую строку ниже
keymap.set("n", "<Leader>O", "O<Esc>^Da", opts) -- Вставить новую строку выше

-- Перемещение по списку переходов
keymap.set("n", "<C-m>", "<C-i>", opts) -- Перейти вперёд по списку переходов

-- Работа с вкладками
keymap.set("n", "te", ":tabedit") -- Открыть новую вкладку
keymap.set("n", "<tab>", ":tabnext<Return>", opts) -- Перейти к следующей вкладке
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts) -- Перейти к предыдущей вкладке

-- Разделение окна
keymap.set("n", "ss", ":split<Return>", opts) -- Горизонтальное разделение
keymap.set("n", "sv", ":vsplit<Return>", opts) -- Вертикальное разделение

-- Перемещение между окнами
keymap.set("n", "sh", "<C-w>h") -- Влево
keymap.set("n", "sk", "<C-w>k") -- Вверх
keymap.set("n", "sj", "<C-w>j") -- Вниз
keymap.set("n", "sl", "<C-w>l") -- Вправо

-- Изменение размера окна
keymap.set("n", "<C-w><left>", "<C-w><") -- Уменьшить ширину
keymap.set("n", "<C-w><right>", "<C-w>>") -- Увеличить ширину
keymap.set("n", "<C-w><up>", "<C-w>+") -- Увеличить высоту
keymap.set("n", "<C-w><down>", "<C-w>-") -- Уменьшить высоту

-- Диагностика
keymap.set("n", "<C-j>", function()
    vim.diagnostic.goto_next() -- Перейти к следующей диагностике
end, opts)

-- Замена HEX на HSL
keymap.set("n", "<leader>r", function()
    require("craftzdog.hsl").replaceHexWithHSL()
end)

-- Переключение подсказок LSP
keymap.set("n", "<leader>i", function()
    require("craftzdog.lsp").toggleInlayHints()
end)

-- Команда для переключения автоформатирования
vim.api.nvim_create_user_command("ToggleAutoformat", function()
    require("craftzdog.lsp").toggleAutoformat()
end, {})
