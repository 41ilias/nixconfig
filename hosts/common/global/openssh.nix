{ outputs, lib, config, ... }:

{
  services.openssh = {
    enable = true;
    settings = {
      # Harden
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      # Automatically remove stale sockets
      StreamLocalBindUnlink = "yes";
      # Allow forwarding ports to everywhere
      GatewayPorts = "clientspecified";
    };

    hostKeys = [
      {
        path = "/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];
  };

  # TODO: investigate why this is useful and why when I enable it I get the following warning:
  # warning: config.security.pam.sshAgentAuth.authorizedKeysFiles contains files in the user's home directory.
  #     Specifying user-writeable files there result in an insecure configuration:
  #     a malicious process can then edit such an authorized_keys file and bypass the ssh-agent-based authentication.
  #     See https://github.com/NixOS/nixpkgs/issues/31611 
  # Passwordless sudo when SSH'ing with keys
  # security.pam.sshAgentAuth.enable = true;

}
