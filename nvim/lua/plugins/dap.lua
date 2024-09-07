return {

   'mfussenegger/nvim-dap',
   dependencies = {
      {
         'rcarriga/nvim-dap-ui',
         dependencies = {
            'nvim-neotest/nvim-nio'
         }
      }
   },
   config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()
      dap.listeners.before.attach.dapui_config = function()
         dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
         dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
         dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
         dapui.close()
      end

      -- C/C++/Rust via lldb-vscode
      dap.adapters.lldb = {
         type = "executable",
         command = "/run/current-system/sw/bin/lldb-vscode",
         name = "lldb",
      }

      dap.configurations.rust = {
         {
            name = 'Launch',
            type = "lldb",
            request = 'launch',
            program = function()
               return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            cwd = '${workspaceFolder}',
            stopOnEntry = false,
            args = {},

            initCommands = function()
               -- Find out where to look for the pretty printer Python module
               local rustc_sysroot = vim.fn.trim(vim.fn.system('rustc --print sysroot'))

               local script_import = 'command script import "' .. rustc_sysroot .. '/lib/rustlib/etc/lldb_lookup.py"'
               local commands_file = rustc_sysroot .. '/lib/rustlib/etc/lldb_commands'

               local commands = {}
               local file = io.open(commands_file, 'r')
               if file then
                  for line in file:lines() do
                     table.insert(commands, line)
                  end
                  file:close()
               end
               table.insert(commands, 1, script_import)

               return commands
            end,
            -- ...,
         }
      }

      vim.keymap.set('n', '<leader>Db', function() dap.toggle_breakpoint() end)
      vim.keymap.set('n', '<leader>Dr', function() dap.run_last() end)
      vim.keymap.set('n', '<leader>Dc', function() dap.continue() end)
      vim.keymap.set('n', '<leader>Dh', function() require("dap.ui.widgets").preview() end)
      vim.keymap.set('n', '<leader>Dl', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
      vim.keymap.set('n', '<leader>Dt', function() dap.terminate() end)

      vim.fn.jobstart('cargo build')
   end

}
