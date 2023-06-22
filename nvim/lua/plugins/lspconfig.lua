return {

   {
      'neovim/nvim-lspconfig',
      lazy = false,
      config = function()
         -- https://github.com/neovim/nvim-lspconfig#Keybindings-and-completion
         local lspconfig = require('lspconfig')

         -- rounded borders for floating stuff
         local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
         function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
            opts = opts or {}
            opts.border = "rounded"
            return orig_util_open_floating_preview(contents, syntax, opts, ...)
         end

         -- Use an on_attach function to only map the following keys
         -- after the language server attaches to the current buffer
         local on_attach = function()
            vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
            vim.keymap.set('n', '<leader>lD', vim.lsp.buf.declaration, { buffer = 0 })
            vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, { buffer = 0 })
            vim.keymap.set('n', '<leader>ld', vim.lsp.buf.definition, { buffer = 0 })
            vim.keymap.set('n', '<leader>lf', vim.lsp.buf.formatting, { buffer = 0 })
            vim.keymap.set('n', '<leader>lh', vim.lsp.buf.hover, { buffer = 0 })
            vim.keymap.set('n', '<leader>ll', vim.diagnostic.open_float, { buffer = 0 })
            vim.keymap.set('n', '<leader>ln', vim.lsp.buf.rename, { buffer = 0 })
            vim.keymap.set('v', '<leader>lf', function() vim.lsp.buf.range_formatting({}) end, { buffer = 0 })

            -- Add borders to :LspInfo floating window
            -- https://neovim.discourse.group/t/lspinfo-window-border/1566/2
            require('lspconfig.ui.windows').default_options.border = 'rounded'
         end

         local capabilities = vim.lsp.protocol.make_client_capabilities()

         lspconfig.rnix.setup {}

         lspconfig.clojure_lsp.setup {
            on_attach = on_attach,
            capabilities = capabilities,
         }

         -- npm i -g vscode-langservers-extracted
         lspconfig.html.setup {
            on_attach = on_attach,
            capabilities = capabilities,
         }

         lspconfig.lua_ls.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
               Lua = {
                  diagnostics = {
                     globals = { 'vim' }
                  }
               }
            }
         }

         -- pip install --user python-lsp-server
         -- lspconfig.pylsp.setup {
         --   on_attach = on_attach,
         -- }

         lspconfig.pyright.setup {
            on_attach = on_attach,
            capabilities = capabilities,
         }

         -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#java_language_server
         lspconfig.java_language_server.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            filetypes = { "java" },
            -- produces error on new buffer:
            -- Error executing vim.schedule lua callback [...]
            -- bad argument #1 to 'ipairs' (table expected, got nil)
            cmd = { "/home/penguino/lsp/java-language-server/dist/lang_server_linux.sh" },
         }

         lspconfig.clangd.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            cmd = { "clangd" },
            filetypes = { "c", "cpp" },
         }

         lspconfig.marksman.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            filetypes = { "markdown" }
         }

         lspconfig.bashls.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            cmd = { "bash-language-server", "start" },
            filetypes = { "sh" }
         }

         lspconfig.rust_analyzer.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            filetypes = { "rust" },
            cmd = { "rust-analyzer" },
            settings = {
               ["rust-analyzer"] = {
                  assist = {
                     importGranularity = "module",
                     importPrefix = "by_self",
                  },
                  cargo = {
                     loadOutDirsFromCheck = true
                  },
                  procMacro = {
                     enable = true
                  },
               }
            }
         }

         vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
            vim.lsp.handlers.hover,
            { border = "rounded" }
         )
         vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
            vim.lsp.handlers.signature_help,
            { border = "rounded" }
         )
      end
   }

}
