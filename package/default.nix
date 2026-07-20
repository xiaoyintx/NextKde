{
  # 本地包集合，通过 overlay 暴露为 pkgs.localpkg
  callPackage,
}:

{
  fcitx5-window-state = callPackage ./fcitx5-window-state { };
}
