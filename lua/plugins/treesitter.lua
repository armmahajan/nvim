return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "VeryLazy",
    config = function()
      -- Modern Neovim (0.10+) enables treesitter highlighting automatically
      -- Just need to ensure parsers are available via :TSInstall <lang>
      -- The build = ":TSUpdate" keeps installed parsers up to date
    end,
  },
}
