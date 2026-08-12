{
  # 使用 Home Manager 安装 clash gui
  home-manager.users.xiaoyintx =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        rustc
        cargo
        rustfmt
        rust-analyzer
      ];
      home.file.".cargo/config.toml" = {
        text = ''
          [source.crates-io]
          replace-with = "ustc"
          [source.ustc]
          registry = "sparse+https://mirrors.ustc.edu.cn/crates.io-index/"
        '';
        force = true;
      };
    };
}
