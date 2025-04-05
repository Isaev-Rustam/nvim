return {
    -- Плагин для цветовой схемы Solarized Osaka
    {
        "craftzdog/solarized-osaka.nvim",
        lazy = true, -- Загружается лениво
        priority = 1000, -- Приоритет загрузки
        opts = function()
            return {
                transparent = true, -- Включить прозрачный фон
            }
        end,
    },
}
