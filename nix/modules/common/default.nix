# configuration applied to all hosts
{ pkgs, lib, config, inputs, userName, hostName, ... }: {
  config = {

    users.mutableUsers = true;

    users.users.${userName} = {
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" ];
    # description = "his whole body is a weapon";
    initialPassword = "password";
  };

  networking.hostName = hostName;
  networking.networkmanager.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 ];
  networking.useDHCP = false;
  networking.hosts."172.29.0.191" = [ "clint" ];
    # these add 1m30s to startup
  # networking.interfaces.enp1s0.useDHCP = true;
  # networking.interfaces.wlp2s0.useDHCP = true;
};
}
