return {

   {
      'saghen/blink.cmp',
      lazy = false, -- lazy loading handled internally
      -- optional: provides snippets for the snippet source
      dependencies = 'rafamadriz/friendly-snippets',

      -- use a release tag to download pre-built binaries
      version = 'v0.*',
      -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
      -- build = 'cargo build --release',

      opts = {
         -- 'default' for mappings similar to built-in completion
         -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
         -- see the "default configuration" section below for full documentation on how to define
         -- your own keymap. when defining your own, no keybinds will
         keymap = 'default',

         highlight = {
            -- sets the fallback highlight groups to nvim-cmp's highlight groups
            -- useful for when your theme doesn't support blink.cmp
            -- will be removed in a future release, assuming themes add support
            use_nvim_cmp_as_default = true,
         },
         -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
         -- adjusts spacing to ensure icons are aligned
         nerd_font_variant = 'mono',

         -- experimental auto-brackets support
         accept = { auto_brackets = { enabled = true } },

         -- experimental signature help support
         trigger = { signature_help = { enabled = true } },

         sources = {
            completion = {
               enabled_providers = { 'lsp', 'path', 'snippets', 'buffer' },
            },
         },

         windows = {
            autocomplete = {
               min_width = 30,
               max_width = 60,
               max_height = 10,
               border = 'rounded',
               -- keep the cursor X lines away from the top/bottom of the window
               scrolloff = 2,
               -- which directions to show the window,
               -- falling back to the next direction when there's not enough space
               direction_priority = { 's', 'n' },
               -- Controls how the completion items are selected
               -- 'preselect' will automatically select the first item in the completion list
               -- 'manual' will not select any item by default
               -- 'auto_insert' will not select any item by default, and insert the completion items automatically when selecting them
               selection = 'auto_insert',
               -- Controls how the completion items are rendered on the popup window
               -- 'simple' will render the item's kind icon the left alongside the label
               -- 'reversed' will render the label on the left and the kind icon + name on the right
               -- 'minimal' will render the label on the left and the kind name on the right
               -- 'function(blink.cmp.CompletionRenderContext): blink.cmp.Component[]' for custom rendering
               draw = {
                  columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 1 }, },
               },
               -- Controls the cycling behavior when reaching the beginning or end of the completion list.
               cycle = {
                  -- When `true`, calling `select_next` at the *bottom* of the completion list will select the *first* completion item.
                  from_bottom = true,
                  -- When `true`, calling `select_prev` at the *top* of the completion list will select the *last* completion item.
                  from_top = true
               },
            },
            documentation = {
               min_width = 10,
               max_width = 60,
               max_height = 20,
               border = 'rounded',
               winhighlight =
                  'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None',
               -- which directions to show the documentation window,
               -- for each of the possible autocomplete window directions,
               -- falling back to the next direction when there's not enough space
               direction_priority = {
                  autocomplete_north = { 'e', 'w', 'n', 's' },
                  autocomplete_south = { 'e', 'w', 's', 'n' },
               },
               auto_show = true,
               auto_show_delay_ms = 200,
               update_delay_ms = 100,
            },
            signature_help = {
               min_width = 1,
               max_width = 100,
               max_height = 10,
               border = 'rounded',
               winhighlight = 'Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder',
            },
         },
      }

   }
}
