{
  # brave
  home-manager.users.winterl =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        brave
      ];
    };
}