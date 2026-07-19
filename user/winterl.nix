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
    # default.custom.yaml - 只切换方案
    xdg.dataFile."fcitx5/rime/default.custom.yaml" = {
      text = ''
        patch:
          schema_list:
            - schema: double_pinyin_flypy
          __include: rime_ice_suggestion:/
      '';
      force = true;
    };
    # 模糊音配置
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

