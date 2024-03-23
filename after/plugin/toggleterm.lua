-- toggles the terminal on and off the screen
require("toggleterm").setup{
    size = function(term)
        if term.direction == "horizontal" then
            return 15
        elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
        end
    end,
    open_mapping = [[<C-\>]],
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = false,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    direction = "float",
    close_on_exit = true,
    shell = "fish",
    float_opts = {
        border = "single",  -- Changed to single border style
        winblend = 0,
        highlights = {
            border = "ToggleTermBorder",
            background = "Normal",
        },
    },
}

-- remaps
local opts = {noremap = true}
vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
--vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
--vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
--vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
--vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)

--my commands
vim.api.nvim_set_keymap('n', '<leader>t', ':ToggleTerm direction=vertical<CR>', { silent = true }) -- not needed since we have a command in the setup

-- Ethan's extra stuff. Not tested
-- vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

-- Define terminal toggle functions
local Terminal = require("toggleterm.terminal").Terminal

local node = Terminal:new({ cmd = "node", hidden = true })

function _NODE_TOGGLE()
 node:toggle()
end

local python = Terminal:new({ cmd = "python3", hidden = true })

function _PYTHON_TOGGLE()
 python:toggle()
end

