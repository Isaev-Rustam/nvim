-- Включаем загрузчик Lua, если он доступен
if vim.loader then
    vim.loader.enable()
end

-- Глобальная функция для отладки
_G.dd = function(...)
    require("util.debug").dump(...) -- Выводим отладочную информацию
end

-- Переопределяем vim.print для использования функции dd
vim.print = _G.dd

-- Загружаем конфигурацию LazyVim
require("config.lazy")
