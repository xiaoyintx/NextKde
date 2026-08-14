{
  lib,
  fetchurl,
  appimageTools,
}:

# 微信 Linux 版（x86_64）
# 写法对齐 nixpkgs 的 pkgs/by-name/we/wechat/linux.nix，
# 区别：源码直接走腾讯国内 CDN 直连，不走 web.archive.org。
let
  pname = "wechat";

  # 从 AppImage 内嵌 .desktop 的 X-AppImage-Version 提取（权威可靠）。
  # 腾讯在 AppImage 里只写到第 3 段版本，第 4 段（构建号）在二进制中且不可靠，
  # 因此这里用 3 段版本号即可（仅影响 derivation 名称，不影响功能）。
  version = "4.1.1";

  src = fetchurl {
    # 腾讯国内官方 CDN（滚动最新版直链，文件名不带版本号）
    url = "https://dldir1v6.qq.com/weixin/Universal/Linux/WeChatLinux_x86_64.AppImage";
    # 由 scripts/wechat-update.sh 检测并在腾讯更新后回填
    hash = "sha256-RX26ArkbAxzdRBLu4HT7v/udnQax5Q/Bgi00hw4RSZA=";
  };

  appimageContents = appimageTools.extract {
    inherit pname version src;
    postExtract = ''
      patchelf --replace-needed libtiff.so.5 libtiff.so $out/opt/wechat/wechat
    '';
  };

  meta = with lib; {
    description = "Messaging and calling app";
    homepage = "https://www.wechat.com/en/";
    downloadPage = "https://linux.weixin.qq.com/en";
    license = licenses.unfree;
    sourceProvenance = [ sourceTypes.binaryNativeCode ];
    mainProgram = "wechat";
    platforms = [ "x86_64-linux" ];
  };
in
appimageTools.wrapAppImage {
  inherit pname version meta;
  src = appimageContents;

  extraInstallCommands = ''
    mkdir -p $out/share/applications
    cp ${appimageContents}/wechat.desktop $out/share/applications/
    mkdir -p $out/share/icons/hicolor/256x256/apps
    cp ${appimageContents}/wechat.png $out/share/icons/hicolor/256x256/apps/

    substituteInPlace $out/share/applications/wechat.desktop --replace-fail AppRun wechat
  '';
}
