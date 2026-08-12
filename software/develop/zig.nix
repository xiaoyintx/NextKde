{
  # Zig + cc/c++ 别名
  home-manager.users.xiaoyintx =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        zig
        zls
        (writeShellScriptBin "zcc" ''exec zig cc "$@"'')
        (writeShellScriptBin "z++" ''exec zig c++ "$@"'')
      ];
    };
}
