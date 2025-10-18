{ lib, ... }:

{
  services.openvpn.servers = {
    unamur  = { config = '' config /home/srk/nixconfig/alcatraz-UDP4-1194-IASIM209_17-config.ovpn ''; };
  };
}
