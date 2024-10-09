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
         -- for keymap, all values may be string | string[]
         -- use an empty table to disable a keymap
         keymap = {
            show = '<C-space>',
            hide = '<C-e>',
            accept = '<Tab>',
            select_prev = { '<Up>', '<C-k>' },
            select_next = { '<Down>', '<C-j>' },

            show_documentation = {},
            hide_documentation = {},
            scroll_documentation_up = '<C-b>',
            scroll_documentation_down = '<C-f>',

            snippet_forward = '<Tab>',
            snippet_backward = '<S-Tab>',
         },

         highlight = {
            -- sets the fallback highlight groups to nvim-cmp's highlight groups
            -- useful for when your theme doesn't support blink.cmp
            -- will be removed in a future release, assuming themes add support
            use_nvim_cmp_as_default = true,
         },
         -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
         -- adjusts spacing to ensure icons are aligned
         nerd_font_variant = 'normal',

         -- experimental auto-brackets support
         accept = { auto_brackets = { enabled = true } },

         -- experimental signature help support
         trigger = { signature_help = { enabled = true } },

         sources = {
            -- similar to nvim-cmp's sources, but we point directly to the source's lua module
            -- multiple groups can be provided, where it'll fallback to the next group if the previous
            -- returns no completion items
            -- WARN: This API will have breaking changes during the beta
            providers = {
               {
                  { 'blink.cmp.sources.lsp' },
                  { 'blink.cmp.sources.path' },
                  { 'blink.cmp.sources.snippets', score_offset = -3 },
               },
               { { 'blink.cmp.sources.buffer' } },
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
               -- Controls how the completion items are rendered on the popup window
               -- 'simple' will render the item's kind icon the left alongside the label
               -- 'reversed' will render the label on the left and the kind icon + name on the right
               -- 'function(blink.cmp.CompletionRenderContext): blink.cmp.Component[]' for custom rendering
               draw = 'simple',
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
