{
    # 使用 Home Manager 安装 scrcpy
    home-manager.users.xiaoyintx =
        { pkgs, ... }:
        {
            home.packages = with pkgs; [
                scrcpy
            ];
        };
}
