{
  # 使用 Home Manager 安装 更纱黑体
  home-manager.users.winterl =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        sarasa-gothic
      ];
    };
}
