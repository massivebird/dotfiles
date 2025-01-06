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

      ---@module 'blink.cmp'
      ---@type blink.cmp.Config
      opts = {
         keymap = {
            preset = "default",
         },

         appearance = {
            -- sets the fallback highlight groups to nvim-cmp's highlight groups
            -- useful for when your theme doesn't support blink.cmp
            -- will be removed in a future release, assuming themes add support
            use_nvim_cmp_as_default = true,
            -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            -- adjusts spacing to ensure icons are aligned
            nerd_font_variant = 'mono',
         },

         sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
            providers = {},
         },

         completion = {
            menu = {
               border = 'rounded',
               min_width = 30,
               max_height = 10,
               scrolloff = 2,
               direction_priority = { 's', 'n' },
               draw = {
                  columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 1 }, },
               },
            },

            list = {
               cycle = {
                  from_bottom = true,
                  from_top = true
               },
               selection = 'auto_insert',
            },

            documentation = {
               auto_show = true,
               auto_show_delay_ms = 200,
               update_delay_ms = 100,
               treesitter_highlighting = true,
               window = {
                  min_width = 10,
                  max_width = 60,
                  max_height = 20,
                  scrollbar = true,
                  border = 'rounded',
                  winhighlight =
                  'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None',
                  direction_priority = {
                     menu_north = { 'e', 'w', 'n', 's' },
                     menu_south = { 'e', 'w', 's', 'n' },
                  },
               },
            },

            accept = {
               create_undo_point = true,
               auto_brackets = {
                  enabled = true,
               },
            },
         },

         signature = {
            enabled = true,
            window = {
               border = "rounded",
               min_width = 1,
               max_height = 10,
               winhighlight = 'Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder',
            },
         }
      }
   }
}
