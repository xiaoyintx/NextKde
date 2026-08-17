{
  # 使用 Home Manager 安装 qq
  home-manager.users.xiaoyintx =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        qq
      ];
    };
}
