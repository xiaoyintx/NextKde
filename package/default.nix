{
  callPackage,
  kosSrc,
}:

let
  kos-desktop = callPackage ./kos-desktop { inherit kosSrc; };
in
{
  inherit kos-desktop;

  kos-shell-data-service = kos-desktop.passthru.shell-data-service;
  kos-kwin-window-bridge = kos-desktop.passthru.kwin-window-bridge;
  kos-settings = kos-desktop.passthru.kos-settings;
  kos-kwin-dock-window-animation = kos-desktop.passthru.kwin-dock-window-animation;
  kos-kwin-context-menu-input = kos-desktop.passthru.kwin-context-menu-input;
  kos-kwin-effects-glass = kos-desktop.passthru.kwin-effects-glass;

  fcitx5-window-state = callPackage ./fcitx5-window-state { };
  wechat = callPackage ./wechat { };
  waywallen-ui = callPackage ./waywallen-ui { };
  waywallen-kde = callPackage ./waywallen-kde { };
  waywallen-gnome = callPackage ./waywallen-gnome { };
  waywallen-layer-shell = callPackage ./waywallen-layer-shell { };
  waywallen-open-wallpaper-engine = callPackage ./waywallen-open-wallpaper-engine { };
}
