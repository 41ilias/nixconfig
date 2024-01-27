{ config, pkgs, inputs, ... }:

{
    programs.neovim = {
        enable = true;
        defaultEditor = true;

        plugins = with pkgs; [
            # colorscheme
            vimPlugins.catppuccin-nvim

            # LSP / CMP
            vimPlugins.nvim-lspconfig
            vimPlugins.nvim-cmp
            vimPlugins.cmp-nvim-lsp
            # vimPlugins.friendly-snippets
            # vimPlugins.luasnip
            # vimPlugins.cmp_luasnip

            # efm pre-configured for formatters and linters
            vimPlugins.efmls-configs-nvim

            # Telescope
            vimPlugins.plenary-nvim
            vimPlugins.telescope-nvim
            vimPlugins.telescope-fzf-native-nvim

            # Treesitter   
            vimPlugins.nvim-treesitter.withAllGrammars
            # vimPlugins.nvim-treesitter-textobjects
            # vimPlugins.nvim-treesitter-context

            # Oil / FileExplorer
            vimPlugins.oil-nvim

            # Usefull stuff
            vimPlugins.gitsigns-nvim
            vimPlugins.comment-nvim

            # Preview Markdown
            vimPlugins.markdown-preview-nvim

            # ChatGPT   
            vimPlugins.ChatGPT-nvim

            # Visuals
            vimPlugins.nui-nvim
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
            # languages
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
        ];
    };
}
