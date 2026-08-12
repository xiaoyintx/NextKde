{
  home-manager.users.xiaoyintx =
    { pkgs, config, ... }:
    {
      home.packages = with pkgs; [
        wechat
      ];
    };
}
