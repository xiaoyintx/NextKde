{
  # 使用 Home Manager 安装 monaspace 可变字体（含 Argon Var）
  home-manager.users.xiaoyintx =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        monaspace
      ];
    };
}