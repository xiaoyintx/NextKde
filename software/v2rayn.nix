{
  # 使用 Home Manager 安装 v2rayN
  home-manager.users.winterl =
    { pkgs, ... }:
    let
      # 把单个 core 包打包成 v2rayN 的 core 目录（可执行文件放在目录根）
      mkCore = name: corePkg: exeName: pkgs.buildEnv {
        inherit name;
        paths = [ corePkg ];
        pathsToLink = [ "/bin" ];
        postBuild = ''
          mv $out/bin/${exeName} $out/${exeName}
          rm -rf $out/bin
        '';
      };

      # geo 数据：v2rayN 约定放在 bin 根目录
      # （xray 通过 XRAY_LOCATION_ASSET=bin 环境变量使用）
      geofiles = pkgs.buildEnv {
        name = "v2rayN-geofiles";
        paths = with pkgs; [
          v2ray-geoip
          v2ray-domain-list-community
        ];
        pathsToLink = [ "/share/v2ray" ];
        postBuild = ''
          mv $out/share/v2ray/geoip.dat $out/geoip.dat
          mv $out/share/v2ray/geosite.dat $out/geosite.dat
          rm -rf $out/share
        '';
      };
    in
    {
      home.packages = with pkgs; [
        v2rayn
        xray
        mihomo
        sing-box
        v2ray-geoip
        v2ray-domain-list-community
      ];

      home.file = {
        # core 目录：bin/<core>/<可执行文件>
        ".local/share/v2rayN/bin/xray" = {
          source = mkCore "v2rayN-core-xray" pkgs.xray "xray";
          force = true;
        };
        ".local/share/v2rayN/bin/mihomo" = {
          source = mkCore "v2rayN-core-mihomo" pkgs.mihomo "mihomo";
          force = true;
        };
        ".local/share/v2rayN/bin/sing_box" = {
          source = mkCore "v2rayN-core-sing-box" pkgs.sing-box "sing-box";
          force = true;
        };
        # geo 数据：bin 根目录
        ".local/share/v2rayN/bin/geoip.dat" = {
          source = "${geofiles}/geoip.dat";
          force = true;
        };
        ".local/share/v2rayN/bin/geosite.dat" = {
          source = "${geofiles}/geosite.dat";
          force = true;
        };
      };
    };
}
