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
            vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, { buffer = 0 })
            vim.keymap.set('n', '<leader>lh', vim.lsp.buf.hover, { buffer = 0 })
            vim.keymap.set('n', '<leader>ll', vim.diagnostic.open_float, { buffer = 0 })
            vim.keymap.set('n', '<leader>ln', vim.lsp.buf.rename, { buffer = 0 })
            vim.keymap.set('n', '<leader>lr', vim.lsp.buf.references, { buffer = 0 })

            -- Levels by name: "TRACE" (0), "DEBUG", "INFO", "WARN", "ERROR", "OFF" (5)
            vim.lsp.set_log_level(1)

            -- Add borders to :LspInfo floating window
            -- https://neovim.discourse.group/t/lspinfo-window-border/1566/2
            require('lspconfig.ui.windows').default_options.border = 'rounded'
         end

         local capabilities = vim.lsp.protocol.make_client_capabilities()

         -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

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

         -- lspconfig.ts_ls.setup {
         --    on_attach = on_attach,
         --    capabilities = capabilities,
         -- }

         -- static type checker for python
         lspconfig.pyright.setup {
            on_attach = on_attach,
            capabilities = capabilities,
         }

         -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#java_language_server
         --
         -- jdtls requires one of the following project files to return diagnostics.
         -- Just touch an empty one or something?
         -- https://github.com/neovim/nvim-lspconfig/blob/3fe1e8de80b98c7a6b16f730711b5eafe84212e1/lua/lspconfig/server_configurations/jdtls.lua#L79
         lspconfig.jdtls.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            cmd = { "jdtls" },
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

         -- https://github.com/rust-lang/rust-analyzer/blob/master/docs/user/generated_config.adoc
         lspconfig.rust_analyzer.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            filetypes = { "rust" },
            cmd = { "rust-analyzer" },
            settings = {
               ["rust-analyzer"] = {
                  -- Add clippy lints for Rust.
                  checkOnSave = {
                     allFeatures = true,
                     command = "clippy",
                     extraArgs = {
                        "--",
                        "--no-deps",
                        "-Dclippy::correctness",
                        "-Dclippy::complexity",
                        "-Wclippy::perf",
                        "-Wclippy::nursery",
                        "-Aclippy::pedantic",
                     },
                  },
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
                  diagnostics = {
                     styleLints = true
                  },
               }
            }
         }

         lspconfig.nixd.setup {
            on_attach = on_attach,
            capabilities = capabilities,
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
