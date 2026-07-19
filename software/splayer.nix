{ config, pkgs, lib, inputs, ... }:

{
  # 使用 Home Manager 安装 splayer
  home-manager.users.winterl = { config, pkgs, ... }: {
    home.packages = with pkgs; [
      splayer
    ];
  };
}
