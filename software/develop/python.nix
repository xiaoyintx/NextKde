{
    home-manager.users.xiaoyintx =
        { pkgs, ... }:
        {
            home.packages = [
                (pkgs.python3.withPackages (
                    ps: with ps; [
                        pip
                        pandas
                        openpyxl
                        # 在此添加需要的包
                    ]
                ))
            ];
        };
}
