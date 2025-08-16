-- Hop configuration
local status_ok, hop = pcall(require, "hop")
if not status_ok then
    return
end

hop.setup({
    keys = 'etovxqpdygfblzhckisuran',
    quit_key = '<Esc>',
    jump_on_sole_occurrence = true,
    case_insensitive = true,
    create_hl_autocmd = true,
})

-- Keybindings
local directions = require('hop.hint').HintDirection
vim.keymap.set('', 'f', function()
    hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
end, { remap = true })
vim.keymap.set('', 'F', function()
    hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
end, { remap = true })
vim.keymap.set('', 't', function()
    hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
end, { remap = true })
vim.keymap.set('', 'T', function()
    hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
end, { remap = true })

-- Word motions
vim.keymap.set('n', '<leader>hw', function()
    hop.hint_words()
end, { desc = "Hop to word" })

-- Line motions
vim.keymap.set('n', '<leader>hl', function()
    hop.hint_lines()
end, { desc = "Hop to line" })

-- Pattern motions
vim.keymap.set('n', '<leader>hp', function()
    hop.hint_patterns()
end, { desc = "Hop to pattern" })

-- Anywhere motions
vim.keymap.set('n', '<leader>ha', function()
    hop.hint_anywhere()
end, { desc = "Hop anywhere" })

-- Character motions (2 chars)
vim.keymap.set('n', '<leader>hc', function()
    hop.hint_char2()
end, { desc = "Hop to 2 chars" })
