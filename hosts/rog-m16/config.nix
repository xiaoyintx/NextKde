{ config, pkgs, lib, hostName, inputs, ... }:

{
  imports = [
    ../../boot/grub.nix

    ../../user/winterl.nix

    ../../gpu/nvidia.nix

    ../../fonts/maple-mono-nf-cn.nix
    ../../fonts/sarasa-gothic.nix

    ../../desktop/gnome/config.nix

    ../../input-method/fcitx5.nix

    ../../software/zed-editor.nix
    ../../software/qq.nix
    ../../software/wechat.nix
    ../../software/feishu.nix
    ../../software/steam.nix
    ../../software/lutris.nix
    ../../software/splayer.nix
    ../../software/obs-studio.nix
  ];

  programs.rog-control-center = {
    enable = true;
    autoStart = true;
  };
  services.asusd.enable = true;

  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;

  hardware.nvidia.prime = {
      intelBusId = "PCI:0@0:2:0";
      nvidiaBusId = "PCI:1@0:0:0";
  };

  system.stateVersion = "26.11";

  i18n.defaultLocale = "zh_CN.UTF-8";

  home-manager.users.winterl = { config, pkgs, ... }: {
    home.stateVersion = "26.11";
  };
}
