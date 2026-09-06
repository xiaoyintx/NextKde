{
    # npm
    home-manager.users.xiaoyintx =
        { pkgs, ... }:
        {
            home.packages = with pkgs; [
                nodejs_26
            ];
        };
}
