{ pkgs, config, lib, ... }:
let
  pinentry =
    if config.gtk.enable then {
      packages = [ pkgs.pinentry-gnome pkgs.gcr ];
      name = "gnome3";
    } else {
      packages = [ pkgs.pinentry-curses ];
      name = "curses";
    };
in
{
  home.packages = pinentry.packages;
  
  programs =
    let
      fixGpg = ''
        gpgconf --launch gpg-agent
      '';
    in
    {
      # Start gpg-agent if it's not running or tunneled in
      # SSH does not start it automatically, so this is needed to avoid having to use a gpg command at startup
      # https://www.gnupg.org/faq/whats-new-in-2.1.html#autostart
      bash.profileExtra = fixGpg;
      zsh.loginExtra = fixGpg;
      fish.loginShellInit = fixGpg;

      gpg = {
        enable = true;
        settings = {
	  # Based on DrDuh gpg.conf (yubikey guide)
          personal-cipher-preferences = "AES256 AES192 AES";
          personal-digest-preferences = "SHA512 SHA384 SHA256";
          personal-compress-preferences = "ZLIB BZIP2 ZIP Uncompressed";
          default-preference-list = "SHA512 SHA384 SHA256 AES256 AES192 AES ZLIB BZIP2 ZIP Uncompressed";
          cert-digest-algo = "SHA512";
          s2k-digest-algo = "SHA512";
          s2k-cipher-algo = "AES256";
          charset = "utf-8";
          fixed-list-mode = true;
          no-comments = true;
          no-emit-version = true;
          no-greeting = true;
          keyid-format = "0xlong";
          list-options = "show-uid-validity";
          verify-options = "show-uid-validity";
          with-fingerprint = true;
          require-cross-certification = true;
          no-symkey-cache = true;
          use-agent = true;
          throw-keyids = true;
        };
        publicKeys = [{
          source = ./gpg-0x81183E9449CCADDF-2022-10-25.asc;
          trust = 5;
        }];
      };
    };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentryFlavor = pinentry.name;
    enableExtraSocket = true;
    sshKeys = [ "149F16412997785363112F3DBD713BC91D51B831" ];
    defaultCacheTtl = 60;
    maxCacheTtl = 120;
  };
}
