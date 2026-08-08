{ pkgs, ... }:

{
  imports = [
    # Boot Loader
    ../../boot/limine.nix
    # User
    ../../user/winterl.nix
    # GPU
    ../../gpu/nvidia.nix
    # Fonts
    ../../fonts/maple-mono-nf-cn.nix
    ../../fonts/sarasa-gothic.nix
    # Desktop Environment
    ../../desktop/plasma/config.nix
    # ../../desktop/gnome/config.nix
    # ../../desktop/cosmic/config.nix
    # Wallpaper
    ../../software/waywallen.nix
    # Input Method
    ../../input-method/fcitx5.nix
    # Desktop Software
    ../../software/clash.nix
    ../../software/zed-editor.nix
    # Browser
    # ../../software/browser/firefox.nix
    ../../software/browser/zen.nix
    # ../../software/browser/brave.nix
    ../../software/qq.nix
    ../../software/wechat.nix
    ../../software/feishu.nix
    ../../software/steam.nix
    ../../software/lutris.nix
    ../../software/splayer.nix
    ../../software/obs-studio.nix
    ../../software/moonlight.nix
    # Develop
    ../../software/develop/clang.nix
    ../../software/develop/zig.nix
    ../../software/develop/rust.nix
    ../../software/develop/csharp.nix
    # KVM
    ./kvm.nix
  ];

  # ROG Control Center
  programs.rog-control-center = {
    enable = true;
    autoStart = true;
  };
  services.asusd.enable = true;

  # Kernel
  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;

  system.stateVersion = "26.11";

  i18n.defaultLocale = "zh_CN.UTF-8";

  home-manager.users.winterl =
    { ... }:
    {
      home.stateVersion = "26.11";
    };
}
