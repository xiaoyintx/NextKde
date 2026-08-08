{
  # 使用 Home Manager 安装 wechat
  # 微信默认请求微软雅黑/思源黑体等字体，在桌面系统下渲染不佳。
  # 这里为微信单独提供一份 fontconfig 配置（~/.config/wechat-fonts/local.conf），
  # 把这些字体重定向到更纱黑体 UI SC，并通过覆盖 desktop 文件设置
  # FONTCONFIG_FILE 环境变量启动，不影响全局字体。
  home-manager.users.winterl =
    { pkgs, config, ... }:
    {
      home.packages = with pkgs; [
        wechat
      ];
    };
}
