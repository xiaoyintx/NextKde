{
  # 使用 Home Manager 安装 zsh 
  home-manager.users.xiaoyintx =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        zsh
      ];
    };
}
