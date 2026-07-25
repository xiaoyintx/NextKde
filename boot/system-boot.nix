{ config, pkgs, lib, hostName, ... }:

{
  boot.loader = {
    systemd-boot = {
      enable = true;
    };
    efi.canTouchEfiVariables = true;
  };
}
