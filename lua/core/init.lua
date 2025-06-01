-- Set up LSP client
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'python',
    callback = function()
        -- Start pylsp and attach to buffer
        local client_id = vim.lsp.start_client({
            cmd = {'pylsp'},
            name = 'pylsp',
            root_dir = vim.fn.getcwd(),  -- Use current dir as project root
            settings = {}  -- Add custom settings here if needed
        })

        if client_id then
            vim.lsp.buf_attach_client(0, client_id)
        else
            vim.notify("Failed to start pylsp", vim.log.levels.ERROR)
        end
    end
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'c,cpp',
    callback = function()
        -- Start pylsp and attach to buffer
        local client_id = vim.lsp.start_client({
            cmd = {'clangd'},
            name = 'clangd',
            root_dir = vim.fn.getcwd(),  -- Use current dir as project root
            settings = {}  -- Add custom settings here if needed
        })

        if client_id then
            vim.lsp.buf_attach_client(0, client_id)
        else
            vim.notify("Failed to start clangd", vim.log.levels.ERROR)
        end
    end
})

-- Enable LSP diagnostics
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = false,
}
)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = 0 })

vim.keymap.set('i', '<C-Space>', '<C-x><C-o>', { buffer = 0 })

vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'

vim.opt.completeopt = {'menuone'}

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
            width = 70,
        }
    ))
end

vim.api.nvim_create_autocmd('CompleteChanged', {
    pattern = '*',
    callback = function()
        if vim.fn.pumvisible() == 1 then
            vim.schedule(custom_hover)
        end
    end,
})

