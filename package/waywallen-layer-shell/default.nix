{ lib, stdenv, fetchzip, patchelf, file }:

stdenv.mkDerivation (finalAttrs: {
  pname = "waywallen-layer-shell";
  version = "0.3.0";

  src = fetchzip {
    url = "https://v6.gh-proxy.org/https://github.com/waywallen/waywallen-display/releases/download/v${finalAttrs.version}/waywallen-layer-shell-${finalAttrs.version}-x86_64.tar.gz";
    hash = "";  # 首次构建报错后填入
    stripRoot = false;
  };

  nativeBuildInputs = [ patchelf file ];

  # 官方安装方式:
  #   install -Dm755 waywallen-layer-shell-<v>-<arch>/waywallen-layer-shell ~/.local/bin/
  #   cp -r waywallen-layer-shell-<v>-<arch>/share ~/.local/
  installPhase = ''
    runHook preInstall

    echo "=== 解压内容（便于调试）==="
    find . -maxdepth 2 -mindepth 1 | sort

    # 自动探测根目录
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

    mkdir -p $out/bin $out/share

    install -Dm755 "$SRC/waywallen-layer-shell" $out/bin/waywallen-layer-shell

    # 复制翻译文件
    cp -r "$SRC"/share/* $out/share/ 2>/dev/null || true

    # 修复解释器（预编译二进制在 NixOS 上需要）
    patchelf --set-interpreter $(cat $NIX_CC/nix-support/dynamic-linker) $out/bin/waywallen-layer-shell

    runHook postInstall
  '';

  meta = {
    description = "Waywallen Wayland layer-shell client";
    homepage = "https://github.com/waywallen/waywallen-display";
    license = lib.licenses.mit;
    platforms = [ "x86_64-linux" ];
    mainProgram = "waywallen-layer-shell";
  };
})
