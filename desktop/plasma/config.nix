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
  ];

  environment.systemPackages =
    with pkgs;
    [
      # 普通软件包
      ghostty
      colloid-icon-theme
      mission-center
      # gtk3 主题
      adw-gtk3
      # 动态壁纸
      localpkg.waywallen-kde
    ]
    ++ (with pkgs.kdePackages; [
      plasma-browser-integration
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
