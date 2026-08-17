{
    # 仅安装 clangd/clang-format 等工具（clang-tools），不安装 clang 编译器
    # 避免与 gcc 的 cc 冲突；clangd 用于 Zed 里 C++ 补全
    home-manager.users.xiaoyintx =
        { pkgs, ... }:
        {
            home.packages = with pkgs; [
                activate-linux
            ];

            systemd.user.services.activate-linux = {
                Unit = {
                    Description = "activate-linux watermark";
                    After = [ "graphical-session.target" ];
                };
                Service = {
                    Type = "simple";
                    ExecStart = "${pkgs.activate-linux}/bin/activate-linux";
                    Restart = "on-failure";
                };
                Install.WantedBy = [ "graphical-session.target" ];
            };
        };

    # activate-linux 显示的水印文字配置
    environment.etc."default/activate-linux".text = ''
        LINE1=激活Nix OS
        LINE2=转到"设置"以激活 NixOS
    '';
}
