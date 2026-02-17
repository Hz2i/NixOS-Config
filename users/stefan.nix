{ config, pkgs, ... }:
{
  users.users.stefan = {
    isNormalUser = true;
    description = "Stefan Amarfii";
    extraGroups = [ "networkmanager" "wheel" "plugdev" "docker"];
    shell = pkgs.fish;
  };
}
