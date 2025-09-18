return {

   {
      'neovim/nvim-lspconfig',
      lazy = false,
      dependencies = {
         {
            "mfussenegger/nvim-jdtls",
            lazy = true,
            ft = "java",
         },
      },
      config = function()
         -- https://github.com/neovim/nvim-lspconfig#Keybindings-and-completion
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
            vim.lsp.inlay_hint.enable(true)
            vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
            vim.keymap.set('n', '<leader>lD', vim.lsp.buf.declaration, { buffer = 0 })
            vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, { buffer = 0 })
            vim.keymap.set('n', '<leader>ld', vim.lsp.buf.definition, { buffer = 0 })
            vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, { buffer = 0 })
            vim.keymap.set('n', '<leader>lh', vim.lsp.buf.hover, { buffer = 0 })
            vim.keymap.set('n', '<leader>ll', vim.diagnostic.open_float, { buffer = 0 })
            vim.keymap.set('n', '<leader>ln', vim.lsp.buf.rename, { buffer = 0 })
            vim.keymap.set('n', '<leader>lr', vim.lsp.buf.references, { buffer = 0 })
            vim.keymap.set('n', "<leader>li",
            function()
               vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end
         )

         -- Levels by name: "TRACE" (0), "DEBUG", "INFO", "WARN", "ERROR", "OFF" (5)
         vim.lsp.set_log_level(4)

         -- Add borders to :LspInfo floating window
         -- https://neovim.discourse.group/t/lspinfo-window-border/1566/2
         require('lspconfig.ui.windows').default_options.border = 'rounded'
      end

      -- Adds a TON of features such as auto-imports
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

      -- npm i -g vscode-langservers-extracted
      vim.lsp.config("html", {
         on_attach = on_attach,
         capabilities = capabilities,
      })

      vim.lsp.config("lua_ls", {
         on_attach = on_attach,
         capabilities = capabilities,
         settings = {
            Lua = {
               diagnostics = {
                  globals = { 'vim' }
               }
            }
         }
      })

      -- Python (static analysis)
      vim.lsp.config("basedpyright", {
         on_attach = on_attach,
         capabilities = capabilities,
      })

      -- Python (code formatting)
      vim.lsp.config("ruff", {
         on_attach = on_attach,
         capabilities = capabilities,

         settings = {
            pyright = {
               -- Using Ruff's import organizer
               disableOrganizeImports = true,
            },
            python = {
               analysis = {
                  -- Ignore all files for analysis to exclusively use Ruff for linting
                  ignore = { '*' },
               },
            },
         },

      })

      -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#jdtls
      --
      -- jdtls requires one of the following project files to return diagnostics.
      -- Just touch an empty one or something?
      -- https://github.com/neovim/nvim-lspconfig/blob/3fe1e8de80b98c7a6b16f730711b5eafe84212e1/lua/lspconfig/server_configurations/jdtls.lua#L79
      vim.lsp.config("jdtls", {
         on_attach = on_attach,
         capabilities = capabilities,
         cmd = { "jdtls" },
      })

      vim.lsp.config("clangd", {
         on_attach = on_attach,
         capabilities = capabilities,
         cmd = {
            "clangd",
            -- https://clang.llvm.org/docs/ClangFormatStyleOptions.html
            "--fallback-style=webkit"
         }
      })

      vim.lsp.config("marksman", {
         on_attach = on_attach,
         capabilities = capabilities,
         filetypes = { "markdown" }
      })

      vim.lsp.config("bashls", {
         on_attach = on_attach,
         capabilities = capabilities,
         cmd = { "bash-language-server", "start" },
         filetypes = { "sh" }
      })

      -- https://github.com/rust-lang/rust-analyzer/blob/master/docs/user/generated_config.adoc
      vim.lsp.config("rust_analyzer", {
         on_attach = on_attach,
         capabilities = capabilities,
         filetypes = { "rust" },
         cmd = { "rust-analyzer" },
         settings = {
            ["rust-analyzer"] = {
               -- Add clippy lints for Rust.
               checkOnSave = true,
               check = {
                  allFeatures = true,
                  command = "clippy",
                  extraArgs = {
                     "--",
                     "--no-deps",
                     "-Wclippy::correctness",
                     "-Wclippy::complexity",
                     "-Wclippy::perf",
                     "-Wclippy::nursery",
                     "-Wclippy::pedantic",
                  },
               },
               inlayHints = {
                  bindingModeHints = {
                     enable = true,
                  }
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
                  enable = true,
                  styleLints = true
               },
            }
         }
      })

      vim.lsp.config("nixd", {
         on_attach = on_attach,
         capabilities = capabilities,
      })

      vim.lsp.config("ts_ls", {
         on_attach = on_attach,
         capabilities = capabilities,
      })

      vim.lsp.config("eslint",{
         capabilities = capabilities,
         on_attach = on_attach(),
      })

      vim.lsp.config("csharp_ls", {
         capabilities = capabilities,
         on_attach = on_attach,
      })

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
