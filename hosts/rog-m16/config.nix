{ pkgs, ... }:

{
  imports = [
    # Boot Loader
    ../../boot/limine.nix
    # User
    ../../user/winterl.nix
    # GPU
    ../../gpu/intel.nix
    ../../gpu/nvidia.nix
    # Fonts
    ../../fonts/maple-mono-nf-cn.nix
    ../../fonts/sarasa-gothic.nix
    # Desktop Environment
    ../../desktop/plasma/config.nix
    # Wallpaper
    ../../software/waywallen.nix
    # Input Method
    ../../input-method/fcitx5.nix
    # Desktop Software
    ../../software/zed-editor.nix
    ../../software/browser/zen.nix
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

  # daed：dae 的现代 Web 面板（二进制内嵌 dae 内核），默认监听 2023，数据目录 /etc/daed。
  # 注意：不再单独启用 services.dae —— daed 会自己管理 dae 实例，
  # 同时跑两个 dae 会抢 eBPF/iptables 导致冲突。
  environment.systemPackages = [
    pkgs.daed
    (pkgs.makeDesktopItem {
      name = "daed";
      desktopName = "daed";
      genericName = "Dae Dashboard";
      comment = "Open the daed web panel";
      exec = "xdg-open http://127.0.0.1:2023";
      icon = "applications-internet";
      terminal = false;
      categories = [ "Network" ];
    })
  ];
  systemd.tmpfiles.rules = [
    "d /etc/daed 0755 root root -"
    # dae-wing 编译路由规则需要 geo 数据，搜索路径包含 /etc/dae-wing
    "d /etc/dae-wing 0755 root root -"
    "L+ /etc/dae-wing/geoip.dat - - - - ${pkgs.v2ray-geoip}/share/v2ray/geoip.dat"
    "L+ /etc/dae-wing/geosite.dat - - - - ${pkgs.v2ray-domain-list-community}/share/v2ray/geosite.dat"
  ];
  systemd.services.daed = {
    description = "daed - Modern dashboard with dae";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.daed}/bin/daed run";
      Restart = "on-failure";
      RestartSec = "5s";
    };
  };

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
