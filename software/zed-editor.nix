{
  # 使用 Home Manager 安装 zed editor
  home-manager.users.xiaoyintx =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        zed-editor
      ];
    };
}
