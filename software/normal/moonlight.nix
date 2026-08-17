{
  # 使用 Home Manager 安装 lutris
  home-manager.users.xiaoyintx =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        moonlight-qt
      ];
    };
}
