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
  libpulseaudio,  # wavsen 音频后端
  libva,          # wavsen VA-API 硬解
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
    # wavsen 音频
    libpulseaudio
    libva
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

    mkdir -p $out/share/waywallen/plugins/org.waywallen.open-wallpaper-engine

    # 直接解压 zip 后放入插件目录：
    # 若顶层只有一个目录则取其内容，否则取全部内容
    SUBDIR=$(find . -mindepth 1 -maxdepth 1 -type d | head -1)
    if [ -n "$SUBDIR" ] && [ $(find . -mindepth 1 -maxdepth 1 | wc -l) -eq 1 ]; then
      cp -rT "$SUBDIR" $out/share/waywallen/plugins/org.waywallen.open-wallpaper-engine
    else
      cp -rT . $out/share/waywallen/plugins/org.waywallen.open-wallpaper-engine
    fi

    runHook postInstall
  '';

  meta = {
    description = "Waywallen open-wallpaper-engine renderer plugin";
    homepage = "https://github.com/waywallen/open-wallpaper-engine";
    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
  };
})
