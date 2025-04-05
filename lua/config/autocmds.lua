-- Выключаем режим вставки (paste), когда выходим из режима вставки
vim.api.nvim_create_autocmd("InsertLeave", {
    pattern = "*",
    command = "set nopaste", -- Отключаем режим вставки
})

-- Отключаем скрытие текста (conceal) для некоторых форматов файлов
-- По умолчанию conceallevel установлен в 3 в LazyVim
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "json", "jsonc", "markdown" }, -- Форматы файлов
    callback = function()
        vim.opt.conceallevel = 0 -- Устанавливаем conceallevel в 0
    end,
})
