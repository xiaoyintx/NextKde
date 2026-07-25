{
  # 使用 Home Manager 安装 Zen Browser (Beta 版本)
  home-manager.users.winterl =
    { pkgs }:
    {
      home.packages = with pkgs; [
        firefox
      ];
    };

  programs.firefox = {
    enable = true;

    languagePacks = [
      "zh-CN"
      "zh-TW"
    ];

    preferences = {
      "privacy.resistFingerprinting" = true;
    };

    policies = {
      DisableTelemetry = true;
    };
  };

}
