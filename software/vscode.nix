{
  # 使用 Home Manager 安装 vscode
  home-manager.users.xiaoyintx =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        vscode
      ];
    };
}
