return {
  "zbirenbaum/copilot.lua",
  event = "BufReadPost",
  opts = function()
    return {
      -- copilot.lua requires an *executable path*, not a shell command
      copilot_node_command = vim.fn.expand("$HOME") .. "/.local/share/mise/installs/node/lts/bin/node", -- Node.js version must be > 22

      -- your usual settings…
      --     suggestion = { enabled = true, auto_trigger = true },
      --    panel = { enabled = false },
      --   filetypes = { markdown = true, help = true },
    }
  end,
}
