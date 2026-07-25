{
  # 使用 Home Manager 安装 nushell
  home-manager.users.winterl =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        nushell
      ];
    };
}
