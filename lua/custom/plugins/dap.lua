local prompt_path_to_exec = function()
  return vim.fn.input({
    prompt = "Path to executable: ",
    default = vim.fn.getcwd() .. "/",
    completion = "file",
  })
end

local prompt_args = function()
  local args_str = vim.fn.input({
    prompt = 'Arguments: ',
  })
  return vim.split(args_str, ' +')
end


return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
    "nvim-neotest/nvim-nio",
    "folke/lazydev.nvim",
  },
  config = function()
    local dap = require("dap")
    local ui = require("dapui")
    local vt = require("nvim-dap-virtual-text")

    ui.setup()
    vt.setup()

    require("lazydev").setup({
      library = { "nvim-dap-ui" },
    })

    local gdb = vim.fn.exepath("gdb")
    if gdb then
      dap.adapters.gdb = {
        type = "executable",
        command = gdb,
        args = { "--interpreter=dap", "--quiet" },
      }

      dap.configurations.c = {
        {
          name = "Debug (GDB)",
          type = "gdb",
          request = "launch",
          program = prompt_path_to_exec,
          cwd = "${workspaceFolder}",
        },
        {
          name = "Debug with arguments (GDB)",
          type = "gdb",
          request = "launch",
          program = prompt_path_to_exec,
          args = prompt_args,
          cwd = "${workspaceFolder}",
        },
      }
    end

    vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
    vim.keymap.set("n", "<leader>gb", dap.run_to_cursor)
    vim.keymap.set("n", "<leader>gr", function()
      ui.open { reset = true }
    end)

    vim.keymap.set("n", "<leader>g1", dap.continue)
    vim.keymap.set("n", "<leader>g2", dap.step_into)
    vim.keymap.set("n", "<leader>g3", dap.step_over)
    vim.keymap.set("n", "<leader>g4", dap.step_out)
    vim.keymap.set("n", "<leader>g5", dap.step_back)
    vim.keymap.set("n", "<leader>g6", dap.restart)

    dap.listeners.before.attach.dapui_config = ui.open
    dap.listeners.before.launch.dapui_config = ui.open
    dap.listeners.before.event_terminated.dapui_config = ui.close
    dap.listeners.before.event_exited.dapui_config = ui.close
  end
}
