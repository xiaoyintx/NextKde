{
  # 使用 Home Manager 安装 qq
  home-manager.users.winterl =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        qq
      ];
    };
}
