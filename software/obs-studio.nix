{
  # 使用 Home Manager 安装 obs-studio
  home-manager.users.winterl =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        obs-studio
      ];
    };
  programs.obs-studio = {
    enableVirtualCamera = true;
  };
}
