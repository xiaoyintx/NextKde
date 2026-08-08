{
  home-manager.users.winterl = { config, pkgs, ... }: {
    # waywallen 桌面程序（AppImage）
    home.packages = [
      pkgs.localpkg.waywallen-ui
    ];

    # waywallen 插件：从系统 store 软链到用户插件目录
    # （waywallen 只扫描 ~/.local/share/waywallen/plugins/，不扫系统路径）
    home.file = {
      ".local/share/waywallen/plugins/org.waywallen.open-wallpaper-engine".source =
        "${pkgs.localpkg.waywallen-open-wallpaper-engine}/share/waywallen/plugins/org.waywallen.open-wallpaper-engine";
    };
  };
}
