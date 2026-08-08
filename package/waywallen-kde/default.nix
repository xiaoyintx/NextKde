{ lib, stdenv, fetchzip }:

stdenv.mkDerivation (finalAttrs: {
  pname = "waywallen-kde";
  version = "0.3.0";

  src = fetchzip {
    url = "https://v6.gh-proxy.org/https://github.com/waywallen/waywallen-display/releases/download/v${finalAttrs.version}/waywallen-kde-${finalAttrs.version}-x86_64-embed.zip";
    hash = "sha256-vvSBq90MdBp6IlkZ8k5wLUFywBivxMCepzfUrt3nAPA=";  # 首次构建报错后填入
    stripRoot = false;
  };

  # 官方安装方式: kpackagetool6 --type Plasma/Wallpaper -i xxx.zip
  # 系统级安装位置: $out/share/plasma/wallpapers/<包名>/
  installPhase = ''
    runHook preInstall

    echo "=== 解压内容（便于调试）==="
    find . -maxdepth 2 -mindepth 1 | sort

    mkdir -p $out/share/plasma/wallpapers

    # 自动探测壁纸包根目录（可能是 waywallen/、waywallen.kwlp/、waywallen-kde-*/ 或散落文件）
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

    cp -rT "$SRC" $out/share/plasma/wallpapers/org.waywallen.kde

    runHook postInstall
  '';

  meta = {
    description = "Waywallen KDE Plasma wallpaper plugin";
    homepage = "https://github.com/waywallen/waywallen-display";
    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
  };
})
