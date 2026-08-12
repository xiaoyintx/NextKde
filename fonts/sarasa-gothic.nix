{
  # 使用 Home Manager 安装 更纱黑体
  home-manager.users.xiaoyintx =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        sarasa-gothic
      ]
    };
}
