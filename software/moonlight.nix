{
  # 使用 Home Manager 安装 lutris
  home-manager.users.winterl =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        moonlight-qt
      ];
    };
}
