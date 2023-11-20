return {
  "stevearc/oil.nvim",
  cmd = "Oil",
  dependencies = {
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            ["<Tab>"] = { "<Cmd>Oil<CR>", desc = "Oil Filebrowser" },
          },
        },
      },
    },
    {
      "rebelot/heirline.nvim",
      opts = function(_, opts)
        local old_disable = opts.opts.disable_winbar_cb
        opts.opts.disable_winbar_cb = function(args)
          if vim.bo[args.buf].filetype == "oil" then
            return false
          else
            return old_disable(args)
          end
        end

        local status = require "astroui.status"
        table.insert(opts.winbar, 1, {
          condition = function(args) return vim.bo[args.bufnr].filetype == "oil" end,
          status.component.separated_path {
            padding = { left = 2 },
            max_depth = false,
            suffix = false,
            path_func = function() return require("oil").get_current_dir() end,
          },
        })
      end,
    },
  },
  opts = {
    keymaps = {
      ["<Tab>"] = "actions.close",
    },
  },
}
