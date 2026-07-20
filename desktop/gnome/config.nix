{ config, pkgs, lib, hostName, ... }:

{
  imports = [
    ../../software/browser/firefox.nix
    ../../software/clash.nix
  ];

  services = {
    desktopManager.gnome = {
      enable = true;
    };
    displayManager.gdm = {
      enable = true;
    };
  };

  programs.nautilus-open-any-terminal = {
    enable = true;
    # terminal = "ghostty";
  };

  environment.systemPackages = with pkgs; [
    # 普通软件包
    ghostty
    refine
    gnome-tweaks
    flameshot
    colloid-icon-theme
    alacarte
    seahorse
    adw-gtk3
    waywallen
    # waywallen gnome 拓展
    waywallen-gnome
    # 本地打包的 GNOME 扩展
    localpkg.fcitx5-window-state
  ] ++ (with pkgs.gnomeExtensions; [
    # GNOME 扩展
    blur-my-shell
    kimpanel
    dash-to-panel
    appindicator
    just-perfection
    gtk4-desktop-icons-ng-ding
    user-themes
    fuzzy-app-search
    copyous
    activate-linux
    workspace-indicator
    coverflow-alt-tab
    app-hider
    rounded-window-corners-reborn
    lock-keys
    caffeine
    compiz-alike-magic-lamp-effect
    applications-overview-tooltip
    luminus-desktop
  ]);

  programs.dconf = {
    enable = true;
    profiles.user.databases = [
      {
        settings = {
          "org/gnome/shell/extensions/copyous" = {
            database-backend = "json";
          };
        };
      }
    ];
  };

  environment.gnome.excludePackages = with pkgs; [
    gnome-console # use ghostty as gnome's default terminal
    gnome-tour
    gnome-user-docs
    epiphany  # GNOME Web 浏览器
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
