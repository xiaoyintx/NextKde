{
  description = "winter_l's portable NixOS configuration";

  # 输入源：Nixpkgs 仓库和 NixOS 的默认模板
  inputs = {
    nixpkgs = {
      # 主镜像源：南京大学（速度快，推荐）
      url = "git+https://mirrors.nju.edu.cn/git/nixpkgs.git?ref=nixos-unstable&shallow=1";

      # 备选镜像源：清华大学
      # url = "git+https://mirrors.tuna.tsinghua.edu.cn/git/nixpkgs.git?ref=nixos-unstable&shallow=1";

      # Nixpkgs 主源（官方Git）
      # url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    # Gitee的镜像源需在 Gitee 上配置 SSH 公钥对后才能使用

    nixos-hardware = {
      # Gitee 镜像源：NixOS 针对特定硬件的优化（需要 ssh key）
      url = "git+ssh://git@gitee.com/mirrors/nixos-hardware.git";

      # Github 镜像源：NixOS 针对特定硬件的优化
      #url = "git+https://v6.gh-proxy.org/https://github.com/NixOS/nixos-hardware.git";

      # NixOS-Hardware 主源（针对特定硬件的优化）
      # url = "github:NixOS/nixos-hardware";
    };

    home-manager = {
      # Gitee 镜像源：Home Manager（需要 ssh key）
      url = "git+ssh://git@gitee.com/mirrors/home-manager-nix.git";

      # Github 镜像源：Home Manager
      #url = "git+https://v6.gh-proxy.org/https://github.com/nix-community/home-manager.git";

      # Home Manager 主源（官方Git）
      # url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # CachyOS 内核
    nix-cachyos-kernel = {
      # Github 镜像源
      url = "git+https://v6.gh-proxy.org/https://github.com/xddxdd/nix-cachyos-kernel.git?ref=release";
      # 主源（官方Git）
      # url = "github:xddxdd/nix-cachyos-kernel/release";
    };

    # Zen Browser（通过 flake.lock 锁定版本，无需手动更新 sha256）
    zen-browser-flake = {
      url = "git+https://v6.gh-proxy.org/https://github.com/youwen5/zen-browser-flake.git";
      # 推荐：跟随主 nixpkgs，共享系统库、避免重复下载 nixpkgs
      # 注意：如果构建 Zen 报错，优先尝试删掉这一行
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nix-cachyos-kernel,
      ...
    }@inputs:
    let
      # 定义所有主机
      hosts = [
        "rog-m16"
      ];

      # 为每个主机创建 NixOS 配置
      mkHost =
        hostName:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/common.nix # 主入口点
            (
              { ... }:
              {
                nixpkgs.overlays = [
                  (final: prev: {
                    localpkg = import ./package { callPackage = final.callPackage; };
                  })
                  nix-cachyos-kernel.overlays.pinned
                ];
              }
            )
          ];
          specialArgs = {
            inherit hostName;
            inherit inputs;
            inherit home-manager;
            inherit self;
          };
        };
    in
    {
      nixosConfigurations = builtins.listToAttrs (
        map (host: {
          name = host;
          value = mkHost host;
        }) hosts
      );
    };
}
