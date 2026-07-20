{ lib, stdenv, fetchurl }:

stdenv.mkDerivation rec {
  pname = "gnome-shell-extension-fcitx5-window-state";
  version = "1";

  src = fetchurl {
    # github 镜像加速
    url = "https://v6.gh-proxy.org/https://github.com/Yii6724XT/fcitx5-window-state/archive/8c55447bbb1af35c662cd1eec5c8c939836a1872.tar.gz";
    # github
    # url = "https://github.com/Yii6724XT/fcitx5-window-state/archive/8c55447bbb1af35c662cd1eec5c8c939836a1872.tar.gz";
    hash = "sha256-nxBX5xMWIJpcu7vW+HSNtr+R+1/b1Xld/tT+ZjPcL+M=";
  };

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/gnome-shell/extensions/fcitx5-window-state@yii6724xt
    cp extension.js metadata.json $out/share/gnome-shell/extensions/fcitx5-window-state@yii6724xt/
    runHook postInstall
  '';

  meta = with lib; {
    description = "GNOME Shell extension for Fcitx5 per-window input method state memory";
    homepage = "https://github.com/Yii6724XT/fcitx5-window-state";
    license = licenses.mit;
    platforms = platforms.linux;
    maintainers = [ ];
  };
}
