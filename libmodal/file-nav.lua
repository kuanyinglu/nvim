-- Use this mode to move around instead of normal mode
local api = vim.api
local libmodal = require('libmodal')

local _COMBOS = {
        j = 'normal! j',
        k = 'normal! k',
        h = 'normal! h',
        l = 'normal! l',
        y = 'normal! y',
        p = 'normal! p',
        y = 'normal! y',
        d = 'normal! d',
        p = 'normal! p',
        s = 'EasyMotion',
        S = 'EasyMotionW'
}

local function _fileNavMode()
    local userInput = string.char(api.nvim_get_var('filenavModeInput'))
    api.nvim_command('set cursorline cursorcolumn')

    if _COMBOS[userInput] then
        api.nvim_command(_COMBOS[userInput])
        cursorLocation = api.nvim_win_get_cursor(0)
    elseif userInput == '' then
        api.nvim_set_var('filenavModeExit', true)
        api.nvim_command('set nocursorline nocursorcolumn')
    end
end

api.nvim_set_var('filenavModeExit', 0)
libmodal.mode.enter('FILENAV', _fileNavMode, true)
