{ pkgs, ... }:

let
    # 1. 覆盖 fcitx5-rime，指定使用 rime-wanxiang 作为数据源
    rime = pkgs.fcitx5-rime.override {
        rimeDataPkgs = with pkgs; [
            rime-wanxiang # 万象拼音方案
        ];
    };
in
{
    i18n.inputMethod = {
        enable = true;
        type = "fcitx5";
        fcitx5 = {
            waylandFrontend = true;
            addons = with pkgs; [
                rime # 使用我们定制后的 rime 包
                fcitx5-gtk
                kdePackages.fcitx5-qt
            ];
        };
    };
}
