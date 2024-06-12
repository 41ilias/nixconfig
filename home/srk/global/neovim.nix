{ config, pkgs, inputs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [
      # colorscheme
      catppuccin-nvim

      # LSP / CMP
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      vim-vsnip
      cmp-vsnip

      # efm pre-configured for formatters and linters
      efmls-configs-nvim

      # Telescope
      plenary-nvim
      telescope-nvim
      telescope-fzf-native-nvim

      # Treesitter   
      nvim-treesitter.withAllGrammars
      # vimPlugins.nvim-treesitter-textobjects
      # vimPlugins.nvim-treesitter-context

      # Oil / FileExplorer
      oil-nvim

      # Usefull stuff
      gitsigns-nvim
      comment-nvim
      vim-sleuth

      # Preview Markdown and Latex
      markdown-preview-nvim
      {
        plugin = vimtex;
        config = /* vim */
          ''
            let g:vimtex_view_method = '${if config.programs.zathura.enable then "zathura" else "general"}'
          '';
      }

      rest-nvim
      nvim-treesitter-parsers.http

      # Visuals
      nui-nvim
      # vimPlugins.nvim-web-devicons
      # vimPlugins.noice-nvim
      # vimPlugins.nvim-notify
      # vimPlugins.lualine-nvim
      # vimPlugins.indent-blankline-nvim
      # vimPlugins.lspkind-nvim

      # I built my lua config as a plugin go -> pkgs/srk-nvim
      # TODO: startup time around 150ms can we improve it?
      #       also I think it feels kinda laggy
      inputs.self.packages.${pkgs.system}.srk-nvim
    ];

    extraConfig = ''
      lua << EOF
      require 'srk'
      EOF
    '';

    extraPackages = with pkgs; [
      # Nix LSP and Formatter
      nil
      # TODO: find out which one to use and how to work with it
      nixpkgs-fmt
      # nixfmt

      nodejs

      # language servers
      # lua-language-server
      efm-langserver
      # nodePackages."bash-language-server"
      # nodePackages."dockerfile-language-server-nodejs"
      nodePackages."pyright"
      nodePackages."typescript-language-server"
      # HTML CSS JSON ESLint
      # nodePackages."vscode-langservers-extracted"
      # nodePackages."yaml-language-server"
      # GO LSP
      # gopls

      # formatters/Linters
      # nixpkgs-fmt
      # gofumpt
      python311Packages.flake8
      python311Packages.black

      # tools
      # fd
      gcc
      # ghc
      # lazydocker
      yarn

      ltex-ls

      terraform-ls
      prettierd
    ];
  };
}
