return {

   {
      'neovim/nvim-lspconfig',
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
            vim.keymap.set('n', '<leader>lh', vim.lsp.buf.hover, { buffer = 0 })
            vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, { buffer = 0 })
            vim.keymap.set('n', '<leader>ln', vim.lsp.buf.rename, { buffer = 0 })
            vim.keymap.set('n', '<leader>ll', vim.diagnostic.open_float, { buffer = 0 })
            vim.keymap.set('n', '<leader>lf', vim.lsp.buf.formatting, { buffer = 0 })
            vim.keymap.set('v', '<leader>lf', function() vim.lsp.buf.range_formatting({}) end, { buffer = 0 })

            -- Add borders to :LspInfo floating window
            -- https://neovim.discourse.group/t/lspinfo-window-border/1566/2
            require('lspconfig.ui.windows').default_options.border = 'rounded'

         end

         lspconfig.clojure_lsp.setup {
            on_attach = on_attach,
         }

         -- lspconfig.lua_ls.setup {
         --    on_attach = on_attach,
         --    settings = {
         --       Lua = {
         --          diagnostics = {
         --             globals = { 'vim' }
         --          }
         --       }
         --    }
         -- }

         -- pip install --user python-lsp-server
         -- lspconfig.pylsp.setup {
         --   on_attach = on_attach,
         -- }

         lspconfig.pyright.setup {
            on_attach = on_attach,
         }

         -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#java_language_server
         lspconfig.java_language_server.setup {
            on_attach = on_attach,
            cmd = { '/home/penguino/java-language-server/dist/lang_server_linux.sh' },
         }

         lspconfig.clangd.setup {
            on_attach = on_attach,
            cmd = { "clangd" },
            filetypes = { "c", "cpp" },
         }

         lspconfig.marksman.setup {
            cmd = { "marksman", "server" },
            filetypes = { "markdown" }
         }

         lspconfig.bashls.setup {
            cmd = { "bash-language-server", "start" },
            filetypes = { "sh" }
         }

         lspconfig.rust_analyzer.setup {
            on_attach = on_attach,
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
