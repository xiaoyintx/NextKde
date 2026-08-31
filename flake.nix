{
    description = "xiaoyintx's portable NixOS configuration";

    inputs = {
        nixpkgs = {
            url = "git+https://mirrors.nju.edu.cn/git/nixpkgs.git?ref=nixos-unstable&shallow=1";
        };

        nixos-hardware = {
            url = "git+ssh://git@gitee.com/mirrors/nixos-hardware.git";
        };

        home-manager = {
            url = "git+https://gitee.com/mirrors/home-manager-nix.git";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        proton-cachyos = {
            url = "git+https://api.gitproxy.dev/github.com/Daaboulex/proton-cachyos-nix.git";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        kos-desktop = {
            url = "git+ssh://git@gitee.com/xiaoyintx_ciallo/test.git";
            # inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs =
        {
            self,
            nixpkgs,
            home-manager,
            kos-desktop,
            ...
        }@inputs:
        let
            hosts = [
                "omen-16"
            ];

            mkHost =
                hostName:
                nixpkgs.lib.nixosSystem {
                    system = "x86_64-linux";
                    modules = [
                        ./hosts/common.nix
                        (
                            { ... }:
                            {
                                nixpkgs.overlays = [
                                    (final: prev: {
                                        localpkg = final.callPackage ./package { kosSrc = kos-desktop; };
                                    })
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
        let
            system = "x86_64-linux";
            pkgs = nixpkgs.legacyPackages.${system};
            localpkg = pkgs.callPackage ./package { kosSrc = kos-desktop; };
        in
        {
            nixosConfigurations = builtins.listToAttrs (
                map (host: {
                    name = host;
                    value = mkHost host;
                }) hosts
            );

            packages.${system} = localpkg // {
                default = localpkg.kos-desktop;
            };
        };
}
