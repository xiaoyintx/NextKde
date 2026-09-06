{
    # Node.js 支持
    home-manager.users.xiaoyintx =
        { pkgs, ... }:
        {
            home.packages = with pkgs; [
                nodejs_26
            ];
        };
}
