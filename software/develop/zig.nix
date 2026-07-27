{
  # Zig + cc/c++ 别名
  home-manager.users.winterl =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        zig
        (writeShellScriptBin "cc" ''exec zig cc "$@"'')
        (writeShellScriptBin "c++" ''exec zig c++ "$@"'')
      ];
    };
}
