{
  # 使用 Home Manager 安装 wechat
  home-manager.users.winterl =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        wechat
      ];
    };
}
