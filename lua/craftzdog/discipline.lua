local M = {}

-- Функция для ограничения частого использования клавиш
function M.cowboy()
    ---@type table?
    local ok = true -- Флаг для проверки успешного выполнения уведомления
    for _, key in ipairs({ "h", "j", "k", "l", "+", "-" }) do -- Перебираем список клавиш
        local count = 0 -- Счетчик нажатий
        local timer = assert(vim.uv.new_timer()) -- Создаем таймер
        local map = key -- Сохраняем текущую клавишу
        vim.keymap.set("n", key, function()
            if vim.v.count > 0 then -- Если используется числовой префикс, сбрасываем счетчик
                count = 0
            end
            if count >= 10 and vim.bo.buftype ~= "nofile" then -- Если клавиша нажата более 10 раз
                ok = pcall(vim.notify, "Полегче, ковбой!", vim.log.levels.WARN, { -- Выводим предупреждение
                    icon = "🤠", -- Иконка уведомления
                    id = "cowboy", -- Уникальный идентификатор уведомления
                    keep = function()
                        return count >= 10 -- Удерживаем уведомление, пока счетчик >= 10
                    end,
                })
                if not ok then -- Если уведомление не удалось, возвращаем клавишу
                    return map
                end
            else
                count = count + 1 -- Увеличиваем счетчик
                timer:start(2000, 0, function() -- Сбрасываем счетчик через 2 секунды
                    count = 0
                end)
                return map -- Возвращаем клавишу
            end
        end, { expr = true, silent = true }) -- Устанавливаем карту клавиш
    end
end

return M
