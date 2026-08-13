{
  # Zig + cc/c++ 别名
  home-manager.users.xiaoyintx =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        gcc
      ];
    };
}
