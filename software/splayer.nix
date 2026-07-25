{
  # 使用 Home Manager 安装 splayer
  home-manager.users.winterl =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        splayer
      ];
    };
}
