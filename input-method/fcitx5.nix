{ config, pkgs, lib, hostName, ... }:

let
  # 1. 覆盖 fcitx5-rime，指定使用 rime-ice 作为数据源
  rime = pkgs.fcitx5-rime.override {
    rimeDataPkgs = with pkgs; [
      rime-ice        # 雾凇拼音方案
    ];
  };
in
{
  #environment.systemPackages = with pkgs; [
  #  fcitx5-mellow-themes
  #];
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      rime  	   # 使用我们定制后的 rime 包
      fcitx5-gtk
    ];
  };
}
