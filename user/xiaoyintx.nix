{
  users.users.xiaoyintx = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    hashedPassword = "$6$DnU7h8IaJPBWsHty$A2Xq9qj87iyRZnRvAjDI6.S93kOhDs5RXJBNhfmB5dtxIZqT35xAW2eY4eynTe80yZO/CWDEqa2ZSLiwzfNcY0";
  };

  # Git全局配置
  programs.git = {
    enable = true;
    config = {
      user.name = "xiaoyintx";
      user.email = "yinyue3260669043@outlook.com";
      core.editor = "nvim";
      init.defaultBranch = "master";
    };
  };

  home-manager.users.xiaoyintx =
    { config, ... }:
    {
      # shell 设置
      programs = {
        kitty = {
          enable = true;
          configFile.text = "";
          envFile.text = "";
        };
      };

      # 微信专用 fontconfig 配置（不修改全局 fonts.fontconfig）
      xdg.configFile."wechat-fonts/local.conf" = {
        text = ''
          <?xml version="1.0"?>
          <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
          <fontconfig>

            <match target="pattern">
              <test qual="any" name="family"><string>Microsoft YaHei UI</string></test>
              <edit name="family" mode="assign" binding="same">
                <string>Sarasa UI SC</string>
              </edit>
            </match>

            <match target="pattern">
              <test qual="any" name="family"><string>Microsoft YaHei</string></test>
              <edit name="family" mode="assign" binding="same">
                <string>Sarasa UI SC</string>
              </edit>
            </match>

            <match target="pattern">
              <test qual="any" name="family"><string>Noto Sans SC</string></test>
              <edit name="family" mode="assign" binding="same">
                <string>Sarasa UI SC</string>
              </edit>
            </match>

            <match target="pattern">
              <test qual="any" name="family"><string>sans-serif</string></test>
              <edit name="family" mode="prepend" binding="strong">
                <string>Sarasa UI SC</string>
              </edit>
            </match>

            <include ignore_missing="yes">/etc/fonts/fonts.conf</include>

          </fontconfig>
        '';
        force = true;
      };

      # 覆盖微信 desktop 文件，使其通过 FONTCONFIG_FILE 使用上面的字体配置启动
      xdg.desktopEntries.wechat = {
        name = "wechat";
        genericName = "Wechat Desktop";
        comment = "微信桌面版";
        exec = "env FONTCONFIG_FILE=${config.home.homeDirectory}/.config/wechat-fonts/local.conf QT_IM_MODULE=fcitx wechat %U";
        icon = "wechat";
        terminal = false;
        categories = [
          "Utility"
        ];
        startupNotify = true;
        type = "Application";
      };
      xdg.configFile."kitty/kitty.conf" = {
        text = ''
          # Kitty 终端配置文件
          # 字体设置 - 与 VS Code 保持一致
          font_family      Monaspace Argon Var
          bold_font         auto
          italic_font       auto
          bold_italic_font  auto
          font_size        12.0

          # 其他常用设置
          cursor_shape     block
          cursor_blink_interval 0
          background_opacity 1.0
          confirm_os_window_close 0

          # 快捷键
          map ctrl+c copy_or_interrupt
          map ctrl+v paste_from_clipboard
        '';
        force = true;
      };

      # 输入法设置

      ## default.custom.yaml - 只切换方案
      xdg.dataFile."fcitx5/rime/default.custom.yaml" = {
        text = ''
          patch:
            schema_list:
              - schema: pinyin_simp
            __include: rime_ice_suggestion:/
        '';
        force = true;
      };
    };
}
