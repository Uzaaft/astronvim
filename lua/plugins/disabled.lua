local disabled = {
  "goolord/alpha-nvim",
  "jay-babu/mason-null-ls.nvim",
  "lukas-reineke/indent-blankline.nvim",
  "nvimtools/none-ls.nvim",
  -- Custom disable stuff
  "Exafunction/codeium.vim",
  "HiPhish/rainbow-delimiters.nvim",
  "nvim-telescope/telescope-bibtex.nvim",
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  "jay-babu/mason-nvim-dap.nvim",
  "kdheepak/cmp-latex-symbols",
  "nvim-neotest/neotest",
}
if vim.fn.has "nvim-0.10" == 1 then table.insert(disabled, "numToStr/Comment.nvim") end

return vim.tbl_map(function(plugin) return { plugin, enabled = false } end, disabled)
