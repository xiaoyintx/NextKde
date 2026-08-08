{
  home-manager.users.winterl =
    { pkgs, config, ... }:
    {
      home.packages = with pkgs; [
        wechat
      ];
    };
}
