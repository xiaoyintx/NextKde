{
  # Zig + cc/c++ 别名
  home-manager.users.winterl =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        clang
      ];
    };
}
