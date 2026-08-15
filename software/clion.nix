{
  # 使用 Home Manager 安装 clion
  home-manager.users.xiaoyintx =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        jetbrains.clion
      ];
    };
}

