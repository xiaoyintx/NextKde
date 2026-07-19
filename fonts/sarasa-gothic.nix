{ config, pkgs, lib, inputs, ... }:

{
  # 使用 Home Manager 安装 更纱黑体
  home-manager.users.winterl = { config, pkgs, ... }: {
    home.packages = with pkgs; [
      sarasa-gothic
    ];
  };
}
