{ lib, ... }:

{

  networking.firewall = {
    allowedUDPPorts = [ 51820 ];
  };

  networking.wg-quick.interfaces = {

    wg0 = {
      address = [ "172.30.30.12/29" ];
      dns = [ "10.17.0.254" "1.1.1.1" ];

      # Path to the private key file.
      #
      # Note: The private key can also be included inline via the privateKey option,
      # but this makes the private key world-readable; thus, using privateKeyFile is
      # recommended.
      privateKey = "4AHY9QWDBMGbgIAo2iS5K1t2lpDaSS3VfrDYJD6BwVg=";

      peers = [
        {
          publicKey = "IA8Nf9gg/qboL7Lylvxscz52cULexbU1XyOb2L8ORnk=";
          presharedKey = "giLnBOw1piy8Ip18VUWu5MmyN9HuQnfozqUsJ5Tn2L8=";
          allowedIPs = [ "10.0.0.0/24" "10.17.0.0/24" "172.30.30.8/29" ];
          endpoint = "srkhome.com:51820"; 
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
