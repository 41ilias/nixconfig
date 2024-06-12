{
  description = "A simple script to preview pdfs and images in fzf (bat as fallback)";

  outputs = { self, nixpkgs }: {

    # Optional but when present it identifies the derivation's main application
    defaultPackage.x86_64-linux = self.packages.x86_64-linux.srk_fzf_previewer;

    packages.x86_64-linux.srk_fzf_previewer =
      let
        pkgs = import nixpkgs { system = "x86_64-linux"; };

        script_name = "srk_fzf_previewer";
        previewer_script = pkgs.writeShellScriptBin script_name ''
          DATE="$(${pkgs.ddate}/bin/ddate +'the %e of %B%, %Y')"
          ${pkgs.cowsay}/bin/cowsay Hello, world! Today is $DATE. | ${pkgs.lolcat}/bin/lolcat
        '';
        script_buildInputs = with pkgs; [ ddate cowsay lolcat ];
      in
      pkgs.symlinkJoin {
        name = script_name;
        paths = [ previewer_script ] ++ script_buildInputs;
        postBuild = "wrapProgram $out/bin/${script_name} --prefix PATH : $out/bin";
      };
  };
}
