{
  pkgs,
  inputs,
  ...
}:
let
  # 通过 flake input 引入 zen-browser-flake，版本由 flake.lock 锁定，
  # 升级时只需执行 nix flake update zen-browser-flake，无需手动更新 sha256。
  zen-browser = inputs.zen-browser-flake.packages.${pkgs.stdenv.hostPlatform.system}.zen-browser;
in
{
  home-manager.users.winterl.home.packages = [ zen-browser ];
}
