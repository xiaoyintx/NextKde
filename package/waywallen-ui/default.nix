{ lib, appimageTools, fetchurl }:

appimageTools.wrapType2 rec {
  pname = "waywallen";
  version = "0.3.1";

  src = fetchurl {
    url = "https://v6.gh-proxy.org/https://github.com/waywallen/waywallen/releases/download/v${version}/waywallen-${version}-x86_64.AppImage";
    hash = "sha256-R1m2gJ1OyOMRmg8AJF/YEDt1JmzQNfA/8BU/uL93oys=";  # 首次构建报错后填入
  };

  extraPkgs = pkgs: with pkgs; [
    dbus
    libxkbcommon
    fontconfig
    freetype
    libGL
    libpulseaudio  # 壁纸音频输出
    pipewire       # PipeWire 客户端
  ];

  # wrapType2 不会自动生成 .desktop，这里手动补一个
  extraInstallCommands = ''
    mkdir -p $out/share/applications
    cat > $out/share/applications/waywallen.desktop <<'EOF'
    [Desktop Entry]
    Type=Application
    Name=Waywallen
    Comment=Waywallen Display Management
    Exec=waywallen
    Icon=waywallen
    StartupWMClass=waywallen
    Categories=Utility;
    Terminal=false
    EOF
  '';

  meta = {
    description = "Waywallen display management UI (Qt/QML)";
    homepage = "https://github.com/waywallen/waywallen";
    license = lib.licenses.mit;
    platforms = [ "x86_64-linux" ];
    mainProgram = "waywallen";
  };
}
