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

    # 动态壁纸
    nix-waywallen = {
      # Github 镜像源
      url = "git+https://v6.gh-proxy.org/https://github.com/gettbitgirl/nix-waywallen.git";

      # 主源（官方Git）
      # url = "github:gettbitgirl/nix-waywallen";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # CachyOS 内核
    chaotic = {
      # Github 镜像源
      url = "git+https://v6.gh-proxy.org/https://github.com/chaotic-cx/nyx.git?ref=nyxpkgs-unstable";
      # 主源（官方Git）
      # url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    };
  };

  outputs = { self, nixpkgs, home-manager, nix-waywallen, chaotic, ... }@inputs:
    let
      # 定义所有主机
      hosts = [
        "rog-m16"
      ];
      
      # 为每个主机创建 NixOS 配置
      mkHost = hostName:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/common.nix  # 主入口点
            ({ config, pkgs, ... }: {
              nixpkgs.overlays = [
                nix-waywallen.overlays.default
                (final: prev: {
                  localpkg = import ./package { callPackage = final.callPackage; };
                })
              ];
            })
            chaotic.nixosModules.default
          ];
          specialArgs = {
            inherit hostName;
            inherit inputs;
            inherit home-manager;
            inherit self;
          };
        };
    in {
      nixosConfigurations = builtins.listToAttrs (
        map (host: {
          name = host;
          value = mkHost host;
        }) hosts
      );
    };
}

