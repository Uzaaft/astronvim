return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-telescope/telescope-live-grep-args.nvim",
    "nvim-telescope/telescope-bibtex.nvim",
    {
      "jay-babu/project.nvim",
      name = "project_nvim",
      event = "VeryLazy",
      opts = { ignore_lsp = { "lua_ls", "julials" } },
    },
  },
  opts = function(_, opts)
    local telescope = require "telescope"
    local actions = require "telescope.actions"
    local lga_actions = require "telescope-live-grep-args.actions"
    return require("astrocore").extend_tbl(opts, {
      defaults = {
        results_title = "",
        selection_caret = "  ",
        layout_config = {
          width = 0.90,
          height = 0.85,
          preview_cutoff = 120,
          horizontal = {
            preview_width = 0.6,
          },
          vertical = {
            width = 0.9,
            height = 0.95,
            preview_height = 0.5,
          },
          flex = {
            horizontal = {
              preview_width = 0.9,
            },
          },
        },
      },
      extensions = {
        bibtex = { context = true, context_fallback = false },
        live_grep_args = {
          auto_quoting = true, -- enable/disable auto-quoting
          mappings = { -- extend mappings
            i = {
              ["<C-a>"] = lga_actions.quote_prompt(),
              ["<C-f>"] = lga_actions.quote_prompt { postfix = " --iglob " },
            },
          },
        },
      },
      pickers = {
        find_files = {
          hidden = true,
          find_command = function(cfg)
            local find_command = { "rg", "--files", "--color", "never" }
            if not cfg.no_ignore then vim.list_extend(find_command, { "--glob", "!**/.git/**" }) end
            return find_command
          end,
        },
        buffers = {
          path_display = { "smart" },
          mappings = {
            i = { ["<C-d>"] = actions.delete_buffer },
            n = { ["d"] = actions.delete_buffer },
          },
        },
      },
    })
  end,
  config = function(...)
    require "astronvim.plugins.configs.telescope"(...)
    local telescope = require "telescope"
    telescope.load_extension "live_grep_args"
    telescope.load_extension "bibtex"
    telescope.load_extension "projects"
  end,
}
