local M = {}
local LazyvimUtil = require("lazyvim.util")

-- Функция для включения/выключения встроенных подсказок LSP
function M.toggleInlayHints()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) -- Переключаем состояние подсказок
end

-- Функция для включения/выключения автоформатирования
function M.toggleAutoformat()
    LazyvimUtil.format.toggle() -- Переключаем состояние автоформатирования
end

return M
