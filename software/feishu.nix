{
  # 使用 Home Manager 安装 feishu
  home-manager.users.winterl =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        feishu
      ];
    };
}
