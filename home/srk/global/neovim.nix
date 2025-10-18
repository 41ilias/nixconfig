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
      neodev-nvim
      nvim-cmp
      cmp-nvim-lsp
      vim-vsnip
      cmp-vsnip
      # Formatter
      conform-nvim
      # Lintter
      nvim-lint

      # Telescope
      plenary-nvim
      telescope-nvim
      telescope-fzf-native-nvim
      telescope-ui-select-nvim
      telescope-manix
      telescope-undo-nvim

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
      # kulala-nvim

      # Visuals
      nui-nvim
      todo-comments-nvim
      nvim-web-devicons
      noice-nvim
      nvim-notify
      lualine-nvim
      indent-blankline-nvim
      lspkind-nvim

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

    extraLuaPackages =  ps: [
      # rest-nvim dependencies
      ps.luarocks
      ps.lua-curl
      ps.xml2lua
      ps.mimetypes
      ps.nvim-nio
    ];

    extraPackages = with pkgs; [
      # Nix LSP and Formatter
      nil
      # TODO: find out which one to use and how to work with it
      nixpkgs-fmt
      # nixfmt

      # rest-nvim dependencies
      lua51Packages.luarocks
      # TODO: Find a way to remove this from here (move to nix develop lua project)
      lua-language-server
      stylua

      # language servers
      # lua-language-server
      # nodePackages."bash-language-server"
      # nodePackages."dockerfile-language-server-nodejs"
      # nodePackages."pyright"
      # nodePackages."typescript-language-server"
      # HTML CSS JSON ESLint
      # nodePackages."vscode-langservers-extracted"
      # nodePackages."yaml-language-server"

      # formatters/Linters
      # nixpkgs-fmt
      # gofumpt
      # python311Packages.flake8
      # python311Packages.black

      # tools
      # fd
      # gcc
      # ghc
      # lazydocker
      # yarn

      # ltex-ls

      # terraform-ls
      # prettierd
    ];
  };
}
