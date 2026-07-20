{ config, pkgs, lib, inputs, ... }:

{
  # 使用 Home Manager 安装 obs-studio
  home-manager.users.winterl = { config, pkgs, ... }: {
    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; {
        wlrobs
      };
    };
  };
  programs.obs-studio = {
    enableVirtualCamera = true;
  };
}
