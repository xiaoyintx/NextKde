{
  # 使用 Home Manager 安装 clash verge
  home-manager.users.xiaoyintx =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        clash-verge-rev
      ];
    };
}
