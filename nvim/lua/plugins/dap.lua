return {

   {
      "mfussenegger/nvim-dap",
      ft = {"python"},
      dependencies = {
         "mfussenegger/nvim-dap-python",
         "rcarriga/nvim-dap-ui",
         "theHamsta/nvim-dap-virtual-text",
      },
      config = function()

         require('dap-python').setup('/home/penguino/.virtualenvs/debugpy/bin/python')

      end
   },

}
