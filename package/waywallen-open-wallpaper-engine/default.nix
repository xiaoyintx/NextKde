{
  lib,
  stdenv,
  fetchurl,
  libarchive,
  file,
  autoPatchelfHook,
  lz4,
  libGL,
  libgbm,
  vulkan-loader,
  wayland,
  libxkbcommon,
  glib,
  ffmpeg_7,
  nspr,
  nss,
  atk,
  at-spi2-atk,
  at-spi2-core,
  dbus,
  cups,
  libxcomposite,
  libxdamage,
  libxfixes,
  libxrandr,
  expat,
  cairo,
  pango,
  systemd,
  alsa-lib,
  fontconfig,
  freetype,
  libdrm,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "waywallen-open-wallpaper-engine";
  version = "0.2.2";

  src = fetchurl {
    url = "https://v6.gh-proxy.org/https://github.com/waywallen/open-wallpaper-engine/releases/download/v${finalAttrs.version}/org.waywallen.open-wallpaper-engine-${finalAttrs.version}-linux-x86_64.zip";
    hash = "sha256-4l9kDCU1vELmcIh1D922i2K2LXOMRI7g8yJHmpOuzrk="; # 首次构建报错后填入
  };

  nativeBuildInputs = [
    libarchive
    file
    autoPatchelfHook
  ];

  buildInputs = [
    lz4
    libGL
    libgbm
    vulkan-loader
    wayland
    libxkbcommon
    glib
    stdenv.cc.cc.lib
    # 视频渲染（FFmpeg 7: libavformat.so.61）
    ffmpeg_7
    # CEF 浏览器组件
    nspr
    nss
    atk
    at-spi2-atk
    at-spi2-core
    dbus
    cups
    expat
    cairo
    pango
    fontconfig
    freetype
    libxcomposite
    libxdamage
    libxfixes
    libxrandr
    # 系统库
    systemd
    alsa-lib
    libdrm
  ];

  dontUnpack = true;

  # waywallen 插件目录: $out/share/waywallen/
  installPhase = ''
    runHook preInstall

    echo "=== 文件类型 ==="
    file "$src"

    # bsdtar 支持 zip（含 Zstd 压缩）、tar、tar.gz
    mkdir -p unpack
    bsdtar -xf "$src" -C unpack || {
      echo "解压失败: $(file -b "$src")"
      exit 1
    }

    cd unpack
    echo "=== 解压内容 ==="
    find . -maxdepth 2 -mindepth 1 | sort

    mkdir -p $out/share/waywallen

    # 自动探测插件根目录
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

    cp -rT "$SRC" $out/share/waywallen/open-wallpaper-engine

    runHook postInstall
  '';

  meta = {
    description = "Waywallen open-wallpaper-engine renderer plugin";
    homepage = "https://github.com/waywallen/open-wallpaper-engine";
    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
  };
})
