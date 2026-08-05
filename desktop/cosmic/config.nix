{ pkgs, ... }:

{
  services = {
    displayManager = {
      cosmic-greeter.enable = true;
    };
    desktopManager.cosmic = {
      enable = true;
      xwayland.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    # 普通软件包
    ghostty
    cosmic-ext-tweaks
    colloid-icon-theme
  ];

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
