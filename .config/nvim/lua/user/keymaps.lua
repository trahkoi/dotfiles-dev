local M = {}

-- harpoon
local harpoon = require("harpoon")
vim.keymap.set('n', '<leader>a', function() harpoon:list():add() end)
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
vim.keymap.set("n", "<C-k>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-j>", function() harpoon:list():next() end)

-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Telescope help tags' })

-- conform
local conform = require("conform")
vim.keymap.set('n', '<leader>f', function()
    conform.format({
        async = true,
        timeout_ms = 500
    })
end, { desc = "Format the current buffer" })

-- spectre
local spectre = require("spectre")
vim.keymap.set('n', '<leader>S', function() spectre:toggle() end,
    { desc = "Toggle Spectre" })
vim.keymap.set('n', '<leader>sw', function() spectre:open_visual({ select_word = true }) end,
    { desc = "Search current word" })
vim.keymap.set('v', '<leader>sw', function() spectre:open_visual() end,
    { desc = "Search current word" })
vim.keymap.set('n', '<leader>sp', function() spectre:open_file_search({ select_word = true }) end,
    { desc = "Search on current file" })

-- lsp
M.setup_lsp_keys = function(buffer_number)
    vim.keymap.set('n', 'gd', require('omnisharp_extended').telescope_lsp_definition,
        { buffer = buffer_number, desc = 'LSP: [G]oto [D]eclarations' })
    vim.keymap.set('n', 'gr', require('omnisharp_extended').telescope_lsp_references,
        { buffer = buffer_number, desc = 'LSP: [G]oto [R]erefences' })
    vim.keymap.set('n', 'gI', require('omnisharp_extended').telescope_lsp_implementation,
        { buffer = buffer_number, desc = 'LSP: [G]oto [I]mplementation' })
    vim.keymap.set('n', 'gD', require('omnisharp_extended').telescope_lsp_type_definition,
        { buffer = buffer_number, desc = 'LSP: [G]oto [D]declaration' })
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = buffer_number, desc = 'LSP: [R]e[n]ame' })
    vim.keymap.set({ 'n', 'x' }, '<leader>ca', vim.lsp.buf.code_action,
        { buffer = buffer_number, desc = 'LSP: [C]ode [A]ction' })
end



return M
