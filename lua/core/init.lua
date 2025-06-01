-- LSP client for python
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'python',
    callback = function()
        -- Start pylsp and attach to buffer
        local client_id = vim.lsp.start_client({
            cmd = {'pylsp'},
            name = 'pylsp',
            root_dir = vim.fn.getcwd(),
        })
        vim.lsp.buf_attach_client(0, client_id)
    end
})

-- LSP client for C/C++
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'c,cpp',
    callback = function()
        -- Start clangd and attach to buffer
        local client_id = vim.lsp.start_client({
            cmd = {'clangd'},
            name = 'clangd',
            root_dir = vim.fn.getcwd(),
        })
        vim.lsp.buf_attach_client(0, client_id)
    end
})

-- show popup
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = 0 })

-- show word suggestions
vim.keymap.set('i', '<C-Space>', '<C-x><C-o>', { buffer = 0 })

vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'

vim.opt.completeopt = {'menuone'}

-- function for controlling the dimension of the popup
local function custom_hover()
    local params = vim.lsp.util.make_position_params()
    
    -- Get completion menu position (if visible)
    local pum_pos = vim.fn.pum_getpos()
    local menu_width = pum_pos and pum_pos.width or 0
    
    vim.lsp.buf_request(0, 'textDocument/hover', params, vim.lsp.with(
        vim.lsp.handlers.hover, {
            -- Popup adjustment
            offset_x = menu_width,
            offset_y = 0,
            max_width = 70,
            max_height = 20,
        }
    ))
end

-- show popup on the side of the code suggestions
vim.api.nvim_create_autocmd('CompleteChanged', {
    pattern = '*',
    callback = function()
        if vim.fn.pumvisible() == 1 then
            vim.schedule(custom_hover)
        end
    end,
})

