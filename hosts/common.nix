{
  pkgs,
  lib,
  hostName,
  inputs,
  home-manager,
  ...
}:

let
  # 导入硬件配置
  hardwareConfig = ./${hostName}/hardware.nix;

  # 导入主机特定配置（这个文件会负责导入所有模块）
  hostConfig = ./${hostName}/config.nix;

  # 检查文件是否存在
  hardwareExists = builtins.pathExists hardwareConfig;
  hostConfigExists = builtins.pathExists hostConfig;

in
{
  # 只导入硬件配置和主机配置
  # 主机配置（config.nix）会负责导入所有模块
  imports = [
    # 首先导入硬件配置
    (
      if hardwareExists then
        hardwareConfig
      else
        (throw "Hardware configuration not found for ${hostName}")
    )

    # 然后导入主机特定配置（这个文件会导入所有模块）
    (if hostConfigExists then hostConfig else (throw "Host configuration not found for ${hostName}"))

    home-manager.nixosModules.home-manager
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    # 在 common.nix 中只设置全局配置，不定义用户
    # 用户配置由各个主机导入 user.nix 并设置版本

    extraSpecialArgs = {
      inherit inputs;
      inherit hostName;
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
    replacements = {
      "https://github.com/" = "https://v6.gh-proxy.org/https://github.com/";
    };
  };

  nix.settings = {
    trusted-users = [ "root" ];
    extra-substituters = [
      "https://mirror.tuna.tsinghua.edu.cn/nix-channels/store"
      "https://mirror.sjtu.edu.cn/nix-channels/store"
      "https://attic.xuyh0120.win/lantian"
    ];
    extra-trusted-public-keys = [
      "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
    ];
  };

  # 所有主机的通用配置
  environment.etc."gitconfig".text = ''
    [url "https://v6.gh-proxy.org/https://github.com/"]
      insteadOf = https://github.com/
  '';
  networking = {
    hostName = lib.mkDefault hostName;
    networkmanager.enable = true;
  };
  time.timeZone = lib.mkDefault "Asia/Shanghai";
  i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";

  environment.systemPackages = with pkgs; [
    fastfetch
    helix
    git
    pciutils
    nixfmt-rs
    nixd
  ];
}
