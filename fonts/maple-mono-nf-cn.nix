{
  # 使用 Home Manager 安装 maple mono 带连字的中文字体
  home-manager.users.xiaoyintx =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        maple-mono.NF-CN
      ];
    };
}
