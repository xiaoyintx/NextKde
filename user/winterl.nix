{ config, pkgs, lib, hostName, ... }:

{
  users.users.winterl = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager"];
    hashedPassword = "$6$mszOvBy9MzYIQyoF$YaXe8p05SKdWnorNZWu3GPzBC54JKFhcH8S4VAk7qW6xm43b3FjKAwLKstet7UIjIlGKkAK81ccCLOXfi5lcN1";
  };

  # Git全局配置
  programs.git = {
    enable = true;
    config = {
      user.name = "winter_l";
      user.email = "hainan_winter_l@outlook.com";
      core.editor = "helix";
      init.defaultBranch = "main";
    };
  };


  home-manager.users.winterl = { config, pkgs, ... }: {
    # shell 设置
    programs = {
      nushell = {
        enable = true;
        configFile.text = ''
        '';
        envFile.text = ''
        '';
      };
      zoxide = {
        enable = true;
        enableNushellIntegration = true;
      };
    };

    # ghostty 设置
    xdg.configFile."ghostty/config.ghostty" = {
      text = ''
      command = nu
      # ========================================================
      # 核心原则：
      # 1. Ctrl+字母 -> 执行编辑器类功能（复制/粘贴/移动/删除）
      # 2. Alt+字母 -> 替代原本 Ctrl+字母 的终端控制信号
      # ========================================================

      # ---------- 复制/粘贴 ----------
      # Ctrl+C 复制，Ctrl+V 粘贴（替代原先的 Ctrl+Shift+C/V）
      keybind = ctrl+c=copy_to_clipboard
      keybind = ctrl+v=paste_from_clipboard

      # ---------- 清屏 ----------
      # Ctrl+L 清屏（替代原先的 Ctrl+Shift+L）
      keybind = ctrl+l=clear_screen

      # ---------- 全选 ----------
      keybind = ctrl+a=select_all

      # ---------- 新增：Ctrl+F 搜索 ----------
      keybind = ctrl+f=start_search

      # ---------- 终端控制信号转移到 Alt 键 ----------
      # 原 Ctrl+F (光标右移) -> Alt+F
      keybind = alt+f=text:\x06

      # 原 Ctrl+A (行首) -> Alt+A
      keybind = alt+a=text:\x01

      # 原 Ctrl+C (中断 SIGINT) -> Alt+C
      keybind = alt+c=text:\x03

      # 原 Ctrl+D (EOF) -> Alt+D
      keybind = alt+d=text:\x04

      # 原 Ctrl+E (行尾) -> Alt+E
      keybind = alt+e=text:\x05

      # 原 Ctrl+O (接受行/CR) -> Alt+O
      keybind = alt+o=text:\x0F

      # 原 Ctrl+W (删除前一个词) -> Alt+W
      keybind = alt+w=text:\x17

      # 原 Ctrl+R (反向搜索历史) -> Alt+R
      keybind = alt+r=text:\x12

      # 原 Ctrl+B (左移光标) -> Alt+B
      keybind = alt+b=text:\x02

      # 原 Ctrl+F (右移光标) -> Alt+F
      keybind = alt+f=text:\x06

      # 原 Ctrl+A (行首) -> Alt+A
      keybind = alt+a=text:\x01

      # 原 Ctrl+U (删除到行首) -> Alt+U
      keybind = alt+u=text:\x15

      # 原 Ctrl+K (删除到行尾) -> Alt+K
      keybind = alt+k=text:\x0B

      # 原 Ctrl+G (响铃/中止) -> Alt+G
      keybind = alt+g=text:\x07

      # 原 Ctrl+Z (挂起) -> Alt+Z
      keybind = alt+z=text:\x1A

      # 原 Ctrl+Q (恢复传输) -> Alt+Q
      keybind = alt+q=text:\x11

      # 原 Ctrl+S (暂停传输) -> Alt+S
      keybind = alt+s=text:\x13

      # ---------- 额外的便捷功能 ----------
      # Ctrl+Backspace 删除前一个词（映射到 Alt+W 的原始功能）
      keybind = ctrl+backspace=text:\x17
      '';
      force = true;
    };

    # 输入法设置

    ## default.custom.yaml - 只切换方案
    xdg.dataFile."fcitx5/rime/default.custom.yaml" = {
      text = ''
        patch:
          schema_list:
            - schema: double_pinyin_flypy
          __include: rime_ice_suggestion:/
      '';
      force = true;
    };
    ## 模糊音配置
    xdg.dataFile."fcitx5/rime/double_pinyin_flypy.custom.yaml" = {
      text = ''
        patch:
          "speller/algebra/":
                - erase/^xx$/
                - derive/^([jqxy])u$/$1v/
                - derive/^([aoe])([ioun])$/$1$1$2/
                - derive/([aei])n$/$1ng/           # an => ang en => eng, in => ing
                - derive/([aei])ng$/$1n/           # ang => an eng => en, ing => in
                - derive/^([zcs])h/$1/             # zh, ch, sh => z, c, s
                - derive/^([zcs])([^h])/$1h$2/     # z, c, s => zh, ch, sh
                - xform/^([aoe])(ng)?$/$1$1$2/
                - xform/iu$/Ⓠ/
                - xform/(.)ei$/$1Ⓦ/
                - xform/uan$/Ⓡ/
                - xform/[uv]e$/Ⓣ/
                - xform/un$/Ⓨ/
                - xform/^sh/Ⓤ/
                - xform/^ch/Ⓘ/
                - xform/^zh/Ⓥ/
                - xform/uo$/Ⓞ/
                - xform/ie$/Ⓟ/
                - xform/(.)i?ong$/$1Ⓢ/
                - xform/ing$|uai$/Ⓚ/
                - xform/(.)ai$/$1Ⓓ/
                - xform/(.)en$/$1Ⓕ/
                - xform/(.)eng$/$1Ⓖ/
                - xform/[iu]ang$/Ⓛ/
                - xform/(.)ang$/$1Ⓗ/
                - xform/ian$/Ⓜ/
                - xform/(.)an$/$1Ⓙ/
                - xform/(.)ou$/$1Ⓩ/
                - xform/[iu]a$/Ⓧ/
                - xform/iao$/Ⓝ/
                - xform/(.)ao$/$1Ⓒ/
                - xform/ui$/Ⓥ/
                - xform/in$/Ⓑ/
                - xlit/ⓆⓌⓇⓉⓎⓊⒾⓄⓅⓈⒹⒻⒼⒽⒿⓀⓁⓏⓍⒸⓋⒷⓃⓂ/qwrtyuiopsdfghjklzxcvbnm/
      '';
      force = true;
    };
  };
}
