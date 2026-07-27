{ pkgs, ... }:

{
  imports = [
    # Boot Loader
    ../../boot/system-boot.nix
    # User
    ../../user/winterl.nix
    # GPU
    ../../gpu/nvidia.nix
    # Fonts
    ../../fonts/maple-mono-nf-cn.nix
    ../../fonts/sarasa-gothic.nix
    # Desktop Environment
    ../../desktop/gnome/config.nix
    # Input Method
    ../../input-method/fcitx5.nix
    # Desktop Software
    ../../software/clash.nix
    ../../software/zed-editor.nix
    ../../software/browser/zen.nix
    ../../software/qq.nix
    ../../software/wechat.nix
    ../../software/feishu.nix
    ../../software/steam.nix
    ../../software/lutris.nix
    ../../software/splayer.nix
    ../../software/obs-studio.nix
    # Develop
    ../../software/develop/zig.nix
    ../../software/develop/rust.nix
    ../../software/develop/csharp.nix
  ];

  # ROG Control Center
  programs.rog-control-center = {
    enable = true;
    autoStart = true;
  };
  services.asusd.enable = true;

  # KVM
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      swtpm.enable = true;
    };
  };
  programs.virt-manager.enable = true;
  users.users.winterl.extraGroups = [ "libvirtd" ];
  environment.systemPackages = with pkgs; [
    dnsmasq
  ];

  # Kernel
  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;

  # NVIDIA Prime
  hardware.nvidia.prime = {
    intelBusId = "PCI:0@0:2:0";
    nvidiaBusId = "PCI:1@0:0:0";
  };

  system.stateVersion = "26.11";

  i18n.defaultLocale = "zh_CN.UTF-8";

  home-manager.users.winterl =
    { ... }:
    {
      home.stateVersion = "26.11";
    };
}
