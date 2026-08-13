{
  # 使用 Home Manager 安装 feishu
  home-manager.users.xiaoyintx =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        opencode
      ];
    };
}
