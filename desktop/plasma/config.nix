{ pkgs, ... }:

{
  services = {
    displayManager = {
      plasma-login-manager.enable = true;
    };
    desktopManager.plasma6.enable = true;
  };

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    konsole
    discover
  ];

  environment.systemPackages =
    with pkgs;
    [
      # 普通软件包
      ghostty
      # 图标
      colloid-icon-theme
      # 控制面板
      mission-center
      # gtk3 主题
      adw-gtk3
      # 动态壁纸
      localpkg.waywallen-kde
      # 圆角
      kde-rounded-corners
    ]
    ++ (with pkgs.kdePackages; [
      plasma-browser-integration
      qtwebsockets
      qtstyleplugin-kvantum
      klassy
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
