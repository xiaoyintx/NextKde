{ lib, stdenv, fetchzip }:

stdenv.mkDerivation (finalAttrs: {
  pname = "waywallen-gnome";
  version = "0.3.0";

  src = fetchzip {
    url = "https://v6.gh-proxy.org/https://github.com/waywallen/waywallen-display/releases/download/v${finalAttrs.version}/waywallen-gnome-${finalAttrs.version}-x86_64.zip";
    hash = "";  # 首次构建报错后填入
    stripRoot = false;
  };

  # 官方安装方式: gnome-extensions install + enable org.waywallen.gnome@waywallen.io
  installPhase = ''
    runHook preInstall

    echo "=== 解压内容（便于调试）==="
    find . -maxdepth 2 -mindepth 1 | sort

    mkdir -p $out/share/gnome-shell/extensions

    # 自动探测扩展根目录
    SRC=""
    for d in */; do
      if [ -d "$d" ]; then
        SRC="$d"
        break
      fi
    done
    if [ -z "$SRC" ]; then
      SRC="."
    fi

    cp -rT "$SRC" $out/share/gnome-shell/extensions/org.waywallen.gnome@waywallen.io

    runHook postInstall
  '';

  passthru = {
    extensionUuid = "org.waywallen.gnome@waywallen.io";
  };

  meta = {
    description = "Waywallen GNOME Shell extension";
    homepage = "https://github.com/waywallen/waywallen-display";
    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
  };
})
