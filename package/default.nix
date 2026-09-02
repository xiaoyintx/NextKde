{
    # 本地包集合，通过 overlay 暴露为 pkgs.localpkg
    callPackage,
}:

{
    fcitx5-window-state = callPackage ./fcitx5-window-state { };
    wechat = callPackage ./wechat { };
    waywallen-ui = callPackage ./waywallen-ui { };
    waywallen-kde = callPackage ./waywallen-kde { };
    waywallen-gnome = callPackage ./waywallen-gnome { };
    waywallen-layer-shell = callPackage ./waywallen-layer-shell { };
    waywallen-open-wallpaper-engine = callPackage ./waywallen-open-wallpaper-engine { };

}
