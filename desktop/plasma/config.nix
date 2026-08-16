{ pkgs, ... }:

{
  services = {
    displayManager = {
      plasma-login-manager.enable = true;
    };
    desktopManager.plasma6.enable = true;
  };

  # 防火墙
  networking.firewall.enable = true;

  environment.systemPackages =
    with pkgs;
    [

      # 图标
      colloid-icon-theme
      # 控制面板
      mission-center

    ]
    ++ (with pkgs.kdePackages; [
      plasma-browser-integration
      qtwebsockets
      # 防火墙
      plasma-firewall
    ]);

  # 启用声音
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse = {
      enable = true;
    };
  };

  services.printing.enable = true;
  services.avahi.enable = true; # 用于发现网络打印机
}
