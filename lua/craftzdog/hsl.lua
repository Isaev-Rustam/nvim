-- Модуль для работы с цветами в форматах HEX, RGB и HSL

local M = {}

local hexChars = "0123456789abcdef" -- Допустимые символы для HEX

-- Функция для преобразования HEX в RGB
function M.hex_to_rgb(hex)
    hex = string.lower(hex) -- Преобразуем HEX в нижний регистр
    local ret = {}
    for i = 0, 2 do
        local char1 = string.sub(hex, i * 2 + 2, i * 2 + 2)
        local char2 = string.sub(hex, i * 2 + 3, i * 2 + 3)
        local digit1 = string.find(hexChars, char1) - 1
        local digit2 = string.find(hexChars, char2) - 1
        ret[i + 1] = (digit1 * 16 + digit2) / 255.0 -- Преобразуем в диапазон [0, 1]
    end
    return ret
end

-- Функция для преобразования RGB в HSL
function M.rgbToHsl(r, g, b)
    local max, min = math.max(r, g, b), math.min(r, g, b)
    local h, s, l = 0, 0, (max + min) / 2

    if max == min then
        h, s = 0, 0 -- Ахроматический случай
    else
        local d = max - min
        s = l > 0.5 and d / (2 - max - min) or d / (max + min)
        if max == r then
            h = (g - b) / d + (g < b and 6 or 0)
        elseif max == g then
            h = (b - r) / d + 2
        elseif max == b then
            h = (r - g) / d + 4
        end
        h = h / 6
    end

    return h * 360, s * 100, l * 100 -- Возвращаем значения в процентах
end

-- Функция для преобразования HSL в RGB
function M.hslToRgb(h, s, l)
    local r, g, b

    if s == 0 then
        r, g, b = l, l, l -- Ахроматический случай
    else
        local function hue2rgb(p, q, t)
            if t < 0 then t = t + 1 end
            if t > 1 then t = t - 1 end
            if t < 1 / 6 then return p + (q - p) * 6 * t end
            if t < 1 / 2 then return q end
            if t < 2 / 3 then return p + (q - p) * (2 / 3 - t) * 6 end
            return p
        end

        local q = l < 0.5 and l * (1 + s) or l + s - l * s
        local p = 2 * l - q

        r = hue2rgb(p, q, h + 1 / 3)
        g = hue2rgb(p, q, h)
        b = hue2rgb(p, q, h - 1 / 3)
    end

    return r * 255, g * 255, b * 255 -- Возвращаем значения в диапазоне [0, 255]
end

-- Функция для преобразования HEX в HSL
function M.hexToHSL(hex)
    local rgb = M.hex_to_rgb(hex)
    local h, s, l = M.rgbToHsl(rgb[1], rgb[2], rgb[3])
    return string.format("hsl(%d, %d%%, %d%%)", math.floor(h + 0.5), math.floor(s + 0.5), math.floor(l + 0.5))
end

-- Функция для преобразования HSL в HEX
function M.hslToHex(h, s, l)
    local r, g, b = M.hslToRgb(h / 360, s / 100, l / 100)
    return string.format("#%02x%02x%02x", r, g, b)
end

-- Функция для замены HEX-кодов на HSL в текущей строке
function M.replaceHexWithHSL()
    -- Получаем номер текущей строки
    local line_number = vim.api.nvim_win_get_cursor(0)[1]

    -- Получаем содержимое строки
    local line_content = vim.api.nvim_buf_get_lines(0, line_number - 1, line_number, false)[1]

    -- Ищем HEX-коды и заменяем их на HSL
    for hex in line_content:gmatch("#[0-9a-fA-F]+") do
        local hsl = M.hexToHSL(hex)
        line_content = line_content:gsub(hex, hsl)
    end

    -- Устанавливаем обновленное содержимое строки
    vim.api.nvim_buf_set_lines(0, line_number - 1, line_number, false, { line_content })
end

return M
