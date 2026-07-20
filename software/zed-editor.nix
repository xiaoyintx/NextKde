{ config, pkgs, lib, inputs, ... }:

{
  # 使用 Home Manager 安装 zed editor
  home-manager.users.winterl = { config, pkgs, ... }: {
    home.packages = with pkgs; [
      zed-editor
    ];
    programs.zed-editor = {
      extensions = [
        "nix"
        "colored-zed-icons-theme"
        "fleet-themes"
        "git-firefly"
      ];
      extraPackages = with pkgs; [
        nixd
      ];
    };
  };
}
