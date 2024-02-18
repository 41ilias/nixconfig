{ inputs, config, pkgs, ... }:
let
  isEd25519 = k: k.type == "ed25519";
  getKeyPath = k: k.path;
  keys = builtins.filter isEd25519 config.services.openssh.hostKeys;
in
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  # TODO: find out how misterio77 doesn't need this programs (Probably cause he uses a bootstrap devShell?)
  environment.systemPackages = with pkgs; [
    sops
    ssh-to-age
  ];

  sops = {
    # All machines should have an ed25519 SSH key created by openssh service. This key is then used to generate an
    # age key from it and all secrets are encrypted/decrypted using this key by sops
    # WARN so make sure that openssh generates a key of type ed25519 
    age.sshKeyPaths = map getKeyPath keys;
  };
}
