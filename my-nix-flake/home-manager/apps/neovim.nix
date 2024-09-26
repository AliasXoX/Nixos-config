{config, pkgs, ...}:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    plugins = [
      pkgs.vimPlugins.dracula-nvim
      pkgs.vimPlugins.vim-devicons
      pkgs.vimPlugins.nerdtree
      pkgs.vimPlugins.ultisnips
      pkgs.vimPlugins.vim-snippets
    ];
  };
}
