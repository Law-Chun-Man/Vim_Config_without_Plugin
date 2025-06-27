-- LSP client for python
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'python',
    callback = function()
        -- Start pylsp and attach to buffer
        local client_id = vim.lsp.start_client({
            cmd = {'pylsp'},
            name = 'pylsp',
            root_dir = vim.fn.getcwd(),
            capabilities = vim.lsp.protocol.make_client_capabilities(),
            settings = {
                pylsp = {
                    plugins = {
                        jedi_completion = {
                            enabled = true,
                            eager = true
                        },
                    }
                }
            }
        })
        vim.lsp.buf_attach_client(0, client_id)

        -- Configure auto-completion
        vim.bo[0].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- show popup
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = 0 })

        -- rename variable
        vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, { buffer = 0 })

        -- show word suggestions
        vim.keymap.set('i', '<C-Space>', '<C-x><C-o>', { buffer = 0 })
        
        -- immediately complete word when pressing ctrl+space
        vim.opt.completeopt = {'menuone'}
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

        -- Configure auto-completion
        vim.bo[0].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- show popup
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = 0 })

        -- rename variable
        vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, { buffer = 0 })

        -- show word suggestions
        vim.keymap.set('i', '<C-Space>', '<C-x><C-o>', { buffer = 0 })
        
        -- immediately complete word when pressing ctrl+space
        vim.opt.completeopt = {'menuone'}
    end
})

-- lsp hover size
local original_hover_handler = vim.lsp.handlers["textDocument/hover"]
local function custom_hover_handler(err, result, ctx, config)
    config = config or {}
    config.border = "none"
    config.max_width = math.floor(vim.o.columns * 0.7)
    config.max_height = math.floor(vim.o.lines * 0.7)
    return original_hover_handler(err, result, ctx, config)
end
vim.lsp.handlers["textDocument/hover"] = custom_hover_handler
