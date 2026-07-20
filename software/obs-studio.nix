{ config, pkgs, lib, inputs, ... }:

{
  # 使用 Home Manager 安装 obs-studio
  home-manager.users.winterl = { config, pkgs, ... }: {
    home.packages = with pkgs; [
      obs-studio
    ];
  };
  programs.obs-studio = {
    enableVirtualCamera = true;
  };
}
