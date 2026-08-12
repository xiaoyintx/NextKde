{ pkgs, ... }:

{
  # 使用 Home Manager 安装 steam
  home-manager.users.xiaoyintx =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        steam
      ];
    };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    extraCompatPackages = with pkgs; [ dwproton-bin ];
  };
}
