{
  home-manager.users.winterl = { config, pkgs, ... }: {
    # 你的现有配置：安装 waywallen-ui 和软链插件
    home.packages = [
      pkgs.localpkg.waywallen-ui
    ];

    home.file = {
      ".local/share/waywallen/plugins/org.waywallen.open-wallpaper-engine".source =
        "${pkgs.localpkg.waywallen-open-wallpaper-engine}/share/waywallen/plugins/org.waywallen.open-wallpaper-engine";
    };

    # ---- waywallen 用户服务 ----
    systemd.user.services.waywallen = {
      Unit = {
        Description = "Waywallen Daemon (no UI)";
        After = [ "graphical-session.target" ];
        PartOf = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.localpkg.waywallen-ui}/bin/waywallen --no-ui";
        Restart = "on-failure";
        RestartSec = 5;
        Type = "simple";
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };
}
