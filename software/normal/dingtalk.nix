{
    # 钉钉 Linux 版：本地化下载 & 新版本 hash 检测

    home-manager.users.xiaoyintx =
        { pkgs, config, ... }:
        {
            home.packages = [ pkgs.localpkg.dingtalk ];
        };
}
